Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7B606A68F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=InxfA0mg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWwZ-0006QZ-9A; Mon, 23 Nov 2026 11:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVWwH-0006NZ-1X
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:30:48 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVWwF-0005Dw-Ba
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:30:44 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67dabd38cdfso3816868d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:30:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451440; cv=none;
 d=google.com; s=arc-20260327;
 b=nhSwlwlVL2MmYpkGfxNoMAPZyyi0FdN71lDY31pK3DWV6IV9KtVhLpiunWI2AkIRA1
 CUyPmlfKV77gtcL426z4rEEjapSlWZrsRQp3oMHbo8baneHtVJWOTT94FxCBAfw8y7ts
 9XJklCMjE3SoN7JRLZwrjz8nJRrcvLoO85rDszE40CrRX2vLXvN9YxBYJEvWBtorGn9q
 3/1CVaN/RVbvCyaExw14DriDXlGy+4/qTNmdPvzwtVai7VAC1ZibWiYgF976JfSP+2uu
 HCh2yOzZniHN15IhSRB8+p7337Nj+MwEsCBSW4QWq43TKmhJgtk72eJkMxLFgogaPpuv
 4xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TvTXObWQOPyQfb7TY5rbzkTdHv511NesEWNtW+9/SUE=;
 fh=/KWRZhwElS2Aq4swtNcFAaN0zcskPQQasleqXgEABTw=;
 b=pKTMDyIWoXAI9oJOtID4rIZT0EZQJsm6mEWvdUTB+Exug6uMY5OntMiGXTX8zX7q3N
 zJRb273QJTG1qHMAp2JwXWNQetoiTJHLIVT9rGdB+vdCxQmUqCqovJMr8LIsrxFRxdpv
 cBdAfTPbRmq12TQJPGI71PLiFKBaffWGJYAPdOWzPVxwoXq1Ns/fGUWliUe0+UbU27/M
 kgH1i70hqvE73HWWjsjh3YZ40FWIhOyhPE8qMHy3WhYZ14VWojd0JlnL4usHOIBDowj7
 FP7FjpYIJ4wiPed52zukXLWLyOLbRYugXSdl6OxgTO8IJkfPv9hm9lTOEVltIDFgnWcx
 eRTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795451440; x=1796056240; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TvTXObWQOPyQfb7TY5rbzkTdHv511NesEWNtW+9/SUE=;
 b=InxfA0mgNSaMr8p4ohiJKaBZ+LiPCJvtBms6ysOz6vGYKHrQ4HrnzPSfcaNJr+YmhF
 ArR18QmWIAerfpLMDEAiYMF04+s7TqAhHPDCWVP0OZ6baqdyRB+OG2Vd/QaMul8hntcJ
 7G6Xhst/TafXuD2Yz78yHkRMQp71dx61TemuBN3KebzdgiAU5aBPjowg96lcRnuoRPq+
 7INo8N31uWztJzKI+TbV7Ph1DMdKUamYv0XHF7x4ggNQTCjYqEAw3+rqqyrx6nskdQQh
 syOnYfsSXmvW8BV4QTplrvxPiWt5CFjEqK5A04bpYCBjDZZPiZk5eyxvzW9WnLP3OPj1
 1wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795451440; x=1796056240;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TvTXObWQOPyQfb7TY5rbzkTdHv511NesEWNtW+9/SUE=;
 b=m92u/lh2UDOMxkQxMj3xntdb/a7Zaq10o1N54xytnO43udhUZWNHI/jbN6HlNz1F0/
 kFPEteWqGtH3b/O4QtUzgaunpcYb5nhhW++o4pvkA6FS2sRcbnOjSiR94BeazEqlwpsr
 cf6/BneviN7pDfs+8E2K/5ntnwVH7mErFMj4rAt9khHvs1J0dAWhAxpK/Xcpdxdz0w8Q
 gtrvdqdCWRW1vT1d5nEAoMDMK1rLuyv9nHeBqATUOXTvWnmqvL6o/TmsSq1ZQi0lEtyR
 St6pnyiOvvKGM773ThsPj794A07vhm+72OLHqx3tAmg1pIlWqzgwnUFcRILr0lCXRjBo
 SD6g==
X-Forwarded-Encrypted: i=1;
 AL+hErEuNlYlM5GgqN2ycsllbTRdwnfPlFc73kSYqrNKn781aUo5Oi13cOOSRyNm4xshhM/vk4TRVzXuHWyW@nongnu.org
X-Gm-Message-State: APuU4Z9sfXfwQCKnYnY5mQx4pC75eU6CLFUHmjYqWGEv4PgmXiDqMALn
 OPcRL4fVIxzHgUURngsIkrhijRsNAU8tvUstNndhUk7HEc97k9GdJ739U1AqKRpauPheqrYQTvx
 FhGZNQcozieEs68184i1OIoOVO1wfnRBS5aeGi4BmZg==
X-Gm-Gg: AZFdTZfkU/DW5V5MQPkobVrz73ehrkQz+G8jvtjGziWT2mLulxWF9MpA7OVUra31uER
 6a/6+KDcJUOFa4yQbmKPaq4NNY5/CVUwofEFQPgXmxJ9z/Au+GyzJfRLHWQ44YINqk/FRNPSq+W
 Gl5p6bzTwidVEeyxBIdzrw9TIXTJSJ2I1LFYF0PkwcSMZKLsakD0wzTYxjGLTIOAYovolTgzM2o
 lIGD9595/D37CzpAxoHf66X829KtHi6o3NAiY4d8iZzb+h5EpLJAT1T79WzzLFrVapdU8DM22AH
 EBkpnH0wyIDQWR8oE5K/EJmBuCB0AcgVcrLm68uy5/+d7z9msZooQe9qS0JDA28yJMsJt/4PFPj
 Y2sV4dsaP15aODkCMfPCiU66V9yOOns+y4livF60uuoA1H+grU5JCCCfjT7yvZa/P/gzYg/AEJ5
 4LrYogaN/39kwubu9mq0TMFqPxlx9kAoQkATVVTkW1Qg==
X-Received: by 2002:a05:690e:804:20b0:67b:f394:1d40 with SMTP id
 956f58d0204a3-67df4404d5emr2687081d50.50.1795451439769; Mon, 23 Nov 2026
 08:30:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
In-Reply-To: <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 16:30:28 +0000
X-Gm-Features: Aa3M54pFDtZFdMN7-KRJWwQuHZbVKcnybaHheJrIhxb8cdKMmEm3W2eIxF-5sPc
Message-ID: <CAFEAcA-sKg9G5ghHgrmEPZe2=fpUpwnGa-F7tScgj0vHgKF+kQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 16:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On the other hand: people are already reviewing *clearly* LLM-produced
> patch series (example
> https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU55pcQphR5s81aQ@mail.gmail.com/T/).
> Doesn't that produce the same kind of peer pressure on core
> maintainers, in fact even more so because they are not warned in
> advance?

If people are already posting LLM-generated series despite the
fact they're against our policy, why would they stop doing that
and instead follow a new policy that says "you should get our
agreement in advance" ?

thanks
-- PMM

