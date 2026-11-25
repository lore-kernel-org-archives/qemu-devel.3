Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC4606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmPMEFPO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aSXd1c/+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW6tv-0005UN-By; Wed, 25 Nov 2026 01:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xW6tr-0005UF-4k
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xW6tp-0005cN-4F
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795589674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQrMtlyF2M2pxoiUkrM/Lv5SYZHZZcHUEnlJhxyEZ28=;
 b=GmPMEFPOyB3TfLln+RvvstQocPLG2hIAmxLM+Cgy/p16Zr0zT5yWkPrC3L6wm5O5GIfyPK
 x5zrTFEz2bN2dzClCxGyZACQsABYdapIG/PNWxCtq/zRPoSj/Mxipm3jItggNEoabvjdwK
 uV+DCzAXTF2oiBiiCiJXXyBy5XGNns4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-FKiQE1j8Mx-AeOCbd_p7xg-1; Wed, 25 Nov 2026 06:54:32 +0000
X-MC-Unique: FKiQE1j8Mx-AeOCbd_p7xg-1
X-Mimecast-MFC-AGG-ID: FKiQE1j8Mx-AeOCbd_p7xg_1795589671
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cde6bb2c56dso2961509a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795589671; cv=none;
 d=google.com; s=arc-20260327;
 b=MP/mkj6YFqIHWNqc/aEP58oAfP6AgDnuCdAbQ40ij0leudZV0AF0myjmln6gcsPv1w
 eyMrBlrtOczna+DjHKZycxXAr93dGcgEZuPYvxMPJ7TN6BDvssCvupkoSXzJSmWldCF3
 y7CCi8iVXRLTsZSL+brN7DtPF9USCwe7tPn2FPByov9Vb4ampobRX5BhBqIKFstJ6CHq
 QM1eBzz6zDmWlrGMIOu1DZmoWP5OZF8BM78XodpwacAHkWzhXg65QLlnKQGd10MhA1c3
 oeZRvGLCiE48++ZIqWiFOMeixrbpHhB4GvG1YMUYWuIE2Z7Uf/H1q5Nk3kfSKne7D6wb
 Og0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BQrMtlyF2M2pxoiUkrM/Lv5SYZHZZcHUEnlJhxyEZ28=;
 fh=BoTtqbKrEajDD7ym15VlQx1Cly8pKpcjUQlpUlRzaUU=;
 b=WPKCMalvx5sujU2m9sVLKtT1CyqVTJexucubv0pEKjRap5rzKimQxJ9nJerTPIH1MW
 0uRmfe7GJsMT8swKqpcAaQpPqJv2A7iCLNa4QNikMvpAgm3BGMp+QyDqBntn65svVPE5
 tePfIDYEcTmj/JmFvk4+SUMLQkVJ2hFYLkXPSvRNaB42KDiRiQ0eg9Ir2OWhqLCcIKpM
 Z1cNzQ3bddVmc7CY8VKMHDmTWquCm2EWoJ4iXyRQEV+7uzBKpsV3ZnjzVy1+qZ8lPFb1
 3Z4kP9bzzsmjEMnHR8GpFo3LHh0PqxEgxsH2Zce6DzQ0rhR2BKLy6aZjPXiI1AUG3nhm
 v7JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795589671; x=1796194471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQrMtlyF2M2pxoiUkrM/Lv5SYZHZZcHUEnlJhxyEZ28=;
 b=aSXd1c/+zgvxrc4XatEm7wYGZxNZod+oUwGB+JZTih00J/43zTYOzW7DUcn81hT45U
 Y5MPPs33JzqHPU5Iir96plIoRh/zWfXlAiTcN/VqayQUVDzWwiegrKfkn8xqfXvhaBd5
 iWJ8kFiVBEurdYHckgyH/bc4WZn8/w+doZsL0XgkeOlzV6aMo/OopUBR352zrwXmj/Nl
 sadFFstZdii3dNYGLPnPEllLfqFdUOmPEZPW/Veu0t45KO8Nd47Icq3VgwS0IDFOQGCa
 Tuwn9pzQaUfgM8sHmZu+JnPltsVtlq1EB74u0osWqPA15ROA3ppxV0CO2KRYtf/UW78s
 CW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795589671; x=1796194471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQrMtlyF2M2pxoiUkrM/Lv5SYZHZZcHUEnlJhxyEZ28=;
 b=DkPg3sgv4n9orC6FNsYIiiUdgBfV+rwrXBDMxaLFhLElhhR8Gu/1IX7tW8fCQAxcCy
 y94oCA8mc1fA8sW+Vk2CJW7Sc8G/itqz68hgfAKgNU3tmzHxKkPJ6P7e/tL4Pk/lJfC7
 niHgi8pACBw+10X1WFldjDAwGwb02zPnvIFIm182TjiZGXl6j740V949GDzc+7abl7Hb
 wjL6NaRbClqGlMEp45GetHpvk7Einrrpv9sWQ3WiqFVC88inTMu6HIt5WIeCJW4aw5nP
 wisOo//OLqGIBlAFxB0hG/CF4vp2BL9UUGwt2vDvdOnFas3VwHkLkBk2dTFa4AZPXJPY
 eEpQ==
X-Gm-Message-State: APuU4Z/ARQunoN0WtmUa4vvhNKqq/dX1TiSKboHybFOoe0OfO8h3y5Go
 VOXe1PQfCL4k4lO2TW/SuSK1Aybj6HDTGB4IuD9iM9MiwUthzIdT11dVi6hm1Ti0csaTghe0ooc
 PfCwxCbkvk/z8mMtOL5ilxhfsT1FjLOie7Vyu7/pxmHHcKqcDPOEnpOFTJxC76xvlMfc9qNRN3L
 iprTcl0oZgOQaY9NrYFTGBH6/jeY6g8Fg=
X-Gm-Gg: AZFdTZftr6QFmgNsJKg7maepJW9CURqasO+J8z/e+i+sCLnZBoyGUW5Yqu+xOa950yy
 c6MPEHHov1YFS6UjZuPcOhcpsUi824mc8vDsODdjom4ooV+fb+s3E4eojGDjl9WHSbi98dBJncV
 tMa+4bsFc6woGoLtHN+UidS8t9aom3WddPw+sIVG6RbkpW7rhmWak0HDTRDoOWNIs7d150GVvaL
 oVmzV8vZxKrOENbHl5EVTuFsAgntCmNEkz82WeOyYMSuskIQHMEVY+JLUO/fQV2Hl04UZlyDSZd
 WDTKv2nOE4ssePiNJ8w6
X-Received: by 2002:a05:6a20:c887:b0:3e2:7030:9080 with SMTP id
 adf61e73a8af0-4014d360840mr16430263637.47.1795589671192; 
 Tue, 24 Nov 2026 22:54:31 -0800 (PST)
X-Received: by 2002:a05:6a20:c887:b0:3e2:7030:9080 with SMTP id
 adf61e73a8af0-4014d360840mr16430250637.47.1795589670747; Tue, 24 Nov 2026
 22:54:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
In-Reply-To: <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Nov 2026 07:54:19 +0100
X-Gm-Features: Aa3M54p2HJAkWqfVqtKNYoYSoRS7N6mDFMyqyYy2-EGiogpyY_GeJHN_UJ6Rszs
Message-ID: <CABgObfYCndVTF2FD-LAFbTSF3Du5W9Yk2uPU6sxqhGPbaKHzhw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, 
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "mst@redhat.com" <mst@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, 
 "berrange@redhat.com" <berrange@redhat.com>, "imp@bsdimp.com" <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 6:34=E2=80=AFAM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
> > +The QEMU community is a collaboration between humans, not AI agent
> > +fa=C3=A7ades. The following items MUST be written by humans [1]_:
> > +
> > +- cover letters and commit messages
> > +
> > +- responses to reviewer comments
> > +
> > +- issue descriptions or comments
> > +
> > +.. [1] Official project agents may be exempted from one or more of the=
se
> > +       rules, at the discretion of the QEMU project maintainer(s).
>
> Where does this put LLM review tools (like Sashiko for example)?

> I have been using Sashiko a bit for catching issues in RISC-V patches
> and was planning on trying to see if we could get an official instance.
> What would it take to have that exempted as part of this?

Mostly, asking. :) In Linux Sashiko started as just the web interface
and emails to the mailing list were added later as an opt-in from
subsystem maintainers, for example.

Paolo


