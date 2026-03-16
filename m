Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE48F53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2C2Q-0001Kl-Gp; Mon, 16 Mar 2026 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2C1o-0001Hs-W5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:47:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2C1n-0000Zx-Bt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:46:56 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso2265292a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683213; cv=none;
 d=google.com; s=arc-20240605;
 b=YRSXqBQqZ6uh7UylppLtUsQqSXeGJnU/esJs+RNKPHsJGHz25v3tdxi7sCk/WtkzbH
 c8s9dkOHu92iX4OKIbfQR+07FbFAlyGUWKYhxVoCwDMvVj60Gi+lxYiwUVo0jrsTKmDZ
 Jzw0pQ9EKfxLSOfDDv5/hzxKZRJLZk6kf2HWvv8+Fxa9y2v7Fz5zkReI8v2KeyJI6ur1
 1wemQqKiK8RhtqmXtlT5NGlBqsg5vBCZ2SfgYy9ojuoszaD/9/UawRCfnEqadU8o87SA
 BPbXKuLS8zgIzdVrljuW5u/8+XsPAEqCjnk+ZJMDe8ZvdRTOYG8xeU26Fq0mZA8TZJBM
 2BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eI3XScg6hLRSv84n+fMg3l39Ex0q+qz90WY7g86WTd4=;
 fh=i4bqhp4tX+yXDV/4yN3Y1brN4XMmOfl+v8GydVIDoOk=;
 b=E0ISlExrUTQd4MkuOBFp2aJa2euKH6kyk2Zl1GK92FOfUzI0cMoL5xiSY3bG8VhG1D
 qH/nrrvSOp++MhssKu4b0TAVLztSh0E3IxvNte3UC5LLHHPpLLmGrkmEL5mm+ExNHkn6
 CDwCWsKtOABWEJkj50/iQCfGZK9oUokwrqmamsKc1cf61+cqJSHUvPjVnYCLua7KwT1B
 zm4wIpRRYPx0KKTLWojveAv9hq9wpFj6e1GhrSLCpEZBgxsmu+JqgsJoC676MQ5KhIcu
 UTLU6xXPFL2MIpxGIke3kus69crD1TMVf7mBJLAaBCmrTYLKvWj6MHn8kklkIJx45x4l
 iYRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683213; x=1774288013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eI3XScg6hLRSv84n+fMg3l39Ex0q+qz90WY7g86WTd4=;
 b=cMhS6UbOrVf1J9oEYU/SIVYFFKDroMYmiO/X7zpzJDcH013XUHZsmgSTjZrlVZ9u79
 cIRe3YKEvUbxgSG9QqXCUDF/5EB88clNSxaZjQggu2FH69gxnD9XhNZZ5XhIhCZGfxnV
 xJRtknwZDNAlPN0cTS7dxti4w6ivNv06Dj1vCoYo5/v/II0rysYZiHgJwpw+oyBEpmpX
 WYhJdFKNDcaXm2wLADKdVwcgmER3pBOFZoso0cBUTyl56rMM8HgKgFhBU6rhIS8xDob+
 QuEDhWILama/j2krZRdeXNeI36JsUnlh+8LuvgX6uLrPPD7iqWyn9oD2604qNmhfpx03
 boHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683213; x=1774288013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eI3XScg6hLRSv84n+fMg3l39Ex0q+qz90WY7g86WTd4=;
 b=VVzCb5Kolf9tIU/kfYW2YqUniAX7gjo0BScbxgVBZdybK5Cxtl5JKBkkFeXe9X9+I9
 iHqBpHACTwQtfwLzvJ01E7TiGWLSWBGU8eO4qo1NQXfzrTbG6IcYz8ks9mFZMV5Nx74K
 2wTpT/PEaawMSZZ/PzlymMMgJOPcY0IWnqa+L1IO79fIdORtuATXvbnRpA3AV3xNC6yf
 wPuzzT6xo/4Dbe1I1NAO3LfJUB4PkdcS/aqOPULwiOROtAperzAPbdOGSkJgihalUjaD
 1wU5/ya0lAU31exGdnO/XYKN7rbMJB1yevqXJqX6MATRHp5I7h+wFW7RyG93nKv67/2R
 /+Ng==
X-Gm-Message-State: AOJu0YymuLsmVaR5otoGfsdI8b9onNhzhwCHopbYRpgH0O+tKJB3Lvqu
 xJCR0r9FjAs87T2Dfvg3HgzgrEhtHrG6ARKIVuZH06jqfIgsUo0KuEDyeuopQ0uCPQC/0StyXD5
 dlSpPRUSfHewKs2DVmDjfkvFPZpMDN1M=
X-Gm-Gg: ATEYQzyIUbX6LWcyf/8HSUjkI1TTAmldZ9g2Klna4xniJ1prBS4n7XDBBw1Fb/m/4a/
 TJJIGwr4G4hnVRyOWGRF9X33KFf5nxnUFwJOeqDZT9lcrGd16wzhuRUOOBTZ3jlUhVfC3KKdt8E
 sTiyQqVz0ePVtrLzcBkmmjaJMsz/dS77h8BI5CPYddvbVMvMPTqmH9MfG2gc2PQPtYI9Bmj1kEy
 ipfbWV36KB1by4qo6Yp7t5XomdaVAClIgLMSk7Hq1vHExNkpUw2yqj/sYAtkjnAXBLelVWI+Zgv
 fJF32Z75pob/oF2FKG/Hhvw0e4EWT7Z+m7iWEXTqJJ0Z0yEo
X-Received: by 2002:a17:90b:4b0b:b0:35b:9e53:e2df with SMTP id
 98e67ed59e1d1-35bada62885mr368968a91.2.1773683213139; Mon, 16 Mar 2026
 10:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-33-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-33-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:46:42 -0600
X-Gm-Features: AaiRm53rckHYZ2gqIkwDmNVzarfraY70agyACdemnMusFvrpqZDaiM0mrCj7_qs
Message-ID: <CAATN3Nr7O+De6kep1Ca1ytVvWVKDCFCWiEmvZ2aMP_ahQgaUBw@mail.gmail.com>
Subject: Re: [PATCH v3 32/32] target/hexagon: Add pcycle setting functionality
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000dd019f064d27cd44"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000dd019f064d27cd44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/cpu_helper.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000dd019f064d27cd44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Signed-off-by: Brian Cain &lt;<a hr=
ef=3D"mailto:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.=
qualcomm.com</a>&gt;<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:quic_mathbe=
rn@quicinc.com" target=3D"_blank">quic_mathbern@quicinc.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_helper.c | 9 +++++++--<br>
=C2=A01 file changed, 7 insertions(+), 2 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></di=
v></div>

--000000000000dd019f064d27cd44--

