Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD7BF4181C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeAl-0005Pu-Vo; Mon, 09 Mar 2026 13:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vzeAT-0005H4-GT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:13:22 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vzeAR-0005Cr-3L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:13:20 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-829756f3ee9so4861388b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076397; cv=none;
 d=google.com; s=arc-20240605;
 b=QTdUMs0V5GlIy/ZlQpzt8m1hVRoT/NvoOtQHul/ESf2Dr1QKdCRJyWaGztDSk8ULa0
 39iESSpbikNsY0AzH9sHgmfqGdRYtfKVPLvTDYy2qZs7JbyuHSNDh6UWByuMiE6H9U96
 9URkpc5i4n7bjGWDG6uFBIwYVFY7Xoe4HgPlIYDcj57lzKTN6U2tErSuNWAWqKRDhPso
 X2zvrl+6uVC0eh1cWFs6ONq07eb4jsbwJqLwH8Cyh43nE/TMAkYp8ehFHNisem3QUSta
 zSdP70vbdxaq58wbdEddIMOxN3uaXRRPkuLVb81UcVfmP1KpsSbAdUCJnkvOk0Zheh3s
 EMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZkaEpHsQCg9q3EO8g5CVVNHYjT4EESMD+Eb6lWGyFcE=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=FV8fVjGkA7QceSaMuj/pI9wmmBIZJ54/ZkDbhIyfmiHABhHK3Pmdi18M3b8fs5KjFz
 14ppv4VeGTKKDlIh0P86MZdmFmqmjTSppCiUv/Y/b8KOi8h5vi9LxzSjyYEV8ie6t8+Y
 sqE9oPgK3vVu5TFcUxscmhxoBrHkeJklmwPFGmew1vzK2pGeqaZqRrIAkIzJtAq07p/j
 rYhsFyQEB3U9wcfdJJIrDZkbpSCtbRruscsnVlSHVSwMAxtpAeXGk6geywiJJAUi3xKL
 ZYXPyJYhjcgmzOqau8ULbcW8vFNN8cLPHrFGUg7I3BauLSrjK+XEVrYPUYK2tA+cOvbj
 vqcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773076397; x=1773681197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkaEpHsQCg9q3EO8g5CVVNHYjT4EESMD+Eb6lWGyFcE=;
 b=CD8pvFJq5smNRTiynzT2ZIV5JvLLTX3VY1MRwpo+2lJEFDtykkXindtSf5xm1I1u/o
 6+IxoZBvtHQjaqs8H7XxW2fcl1zX5McdaPmNAc9V6VCj1ZLhQB8ALPqJ5MLgmjIMz6pC
 T7s2Zg3XgRtq3DYgyWKhrOvt/lceWr1ZDytFg+JphhWfULeYINHZREjWKaFK4KVzDplf
 SARXt7TtmsWl4N8b/oBSFQE422ue34X2rtX7AqT+Rk22cSXkt4lUO7GfkbllD/8D6yH7
 WHd/2PpvoR9w/eHimO3kn23qmK8qGkvouFJZO/hB0JuXK7OLAO8Hwh3l517HJ0rnn6Ij
 e0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076397; x=1773681197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkaEpHsQCg9q3EO8g5CVVNHYjT4EESMD+Eb6lWGyFcE=;
 b=XyacW0R0gvnwuPHnbgZ/Xwhs32uYln8v8VzfutLYPbILbbTBegnywpLVRljcCS7uOr
 h8uzYX2UorzjZdBuW2JyMuUBnKEYNpdnaKE42iX3HiRQEPNkp0RHgptMjKQoR31nzPRP
 HVW7W4lcCQTx2cRlLWe3yD/gKo1Mf7W6hciwfBv4kaMX4NV8If3Kuc4uWJDJqnfwjz2V
 baWRjg8XNSu37+N+TASkFgkUDCdcbqjJS9mqA44KRSA8XMsytbWppgz3U9KXPvRPeYek
 KYaNKj7hFYgC8X0yBjze4TI3QVzPjlvjnRaoWvMiP12K6OUyhXofBOUL29RBYmBxnSWB
 DHXA==
X-Gm-Message-State: AOJu0YwrrOPun3lrJheV7SyvvqkhG7dz7hd9IRkYFdzi8PeDGPlGjXc6
 fqhyB6iJXI2FTrSI+qCUi/h21zAqugnQPM/6rgRffyPJfWJ5Ta+Ie2f/qrhhIjOEinB9nPtaG1N
 CVz/swnQHhRA03B2SfXH09Yqdscnq7zU=
X-Gm-Gg: ATEYQzxggv1eKBI4bEIpq+sXX4PSoQGlmICCrHtOmzwDNgSZjuKgCY7gQh+iXFp1RK0
 JQTYYKzLJYzMVFvSmc6AadYijfNxupjGczp2GEazMWLGex4gkRDzj1gqGEaNHxnVpcP/YY3B3O7
 ehQuwHn63JXJ0rpMrennbOAbpmv+fCRMVRsQARfzpkEXD0G177jPhgK9bVIBhqDIj4TGzFPZv8q
 6omDEAyyKPb5WotQJ/uZ4ZFZ4Nq5yn6nQVKs9pGMU4qGjAbNM0vyqZmegFkH3klGPLra5dCZOKC
 thzhqrgaNQvmVgbon/kcSa8KVdluYUdkGFLnQg==
X-Received: by 2002:a05:6a20:ce4d:b0:366:19e9:f43 with SMTP id
 adf61e73a8af0-39858fb5c27mr12142117637.6.1773076397433; Mon, 09 Mar 2026
 10:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260309144822.877695-12-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 9 Mar 2026 11:13:05 -0600
X-Gm-Features: AaiRm51fzwqA4P-3QUNBY3mfTDOEot9QN2RWkz9Zc9TXnivDFbpcLSdfdYwKACU
Message-ID: <CAATN3NqJr+JB663_2GGz-fRQXvWxqKdptgeZVH9M6t+h1+pP8g@mail.gmail.com>
Subject: Re: [PATCH v4 11/35] target/hexagon: Add guest, system reg number defs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000d427c2064c9a84d2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42d.google.com
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

--000000000000d427c2064c9a84d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h      |   7 +++
>  target/hexagon/hex_regs.h | 117 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000d427c2064c9a84d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2026 at 8:48=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mailt=
o:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +++<br>
=C2=A0target/hexagon/hex_regs.h | 117 +++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 124 insertions(+)<br></blockquote><div><br></div><di=
v>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000d427c2064c9a84d2--

