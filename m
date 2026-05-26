Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E330ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyvu-0004h0-J9; Tue, 26 May 2026 17:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRyvs-0004gd-Kq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:03:24 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRyvq-0002Fg-K2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:03:24 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-3044857f09aso6549339eec.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829401; cv=none;
 d=google.com; s=arc-20240605;
 b=YrZBGd6gtugSrMolNC5aXmi37xV1jW2YM1iL6HX1F3q5KLsxJJ7z+ffVu9Df2NH9RF
 MHxaXqFdrxx+PPmHu40jhftfpL9lWDwhQg5aHoIeMLICvstxsNcAzqrVnQAC5Nm4eKz8
 7ct3kadYCdkQTL1CP0IeCwHyf6aOBCM0BR4z/6+HArE/CROgSdDv6D9X+AnBF9Jc3kC1
 0Y8zmGzSOx8Wr5xbuLZRf2mjctGVw0dcHwwXiZYvUu/nEOP/MCBaA+DBHFpnvHNSxqJA
 c18IyKCdih9iOvyx2LmTd6x3T9/OWofc6gB8jtrZv46IiuugfSoN4Afn5eIiKfWeHopF
 xWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KlOoT/qE+jmsU630R365P8zuAldHusIC0FuzQCFBsOU=;
 fh=aTLuyXlwQfT99ysDtaVJPnMEDlPrmJvWqIb/N8O0C2Q=;
 b=HXlgm/lAD819BM+DcJtdubR8Z95fgUpCJnKcOnUREsg6h5F4bih2X7hOJSV532lqFt
 6R80a50bJKes3HBPuv5WWLLujJzX2Cc2m68fG73R9HVb/MevSn5z2GRyuvujxKMa42Fi
 UUVZ0sa2SAlSjcAKRkcmxJqIrX5pub7GCXBUtI7P088UCndcB4RCuQOmrG/lXQZETqUn
 foi2JFmxdEPRCr49R8focwpgwufxUEQKoxnxeHB7ntpECtnEyub+tqtYaHqh+a1RV9aV
 A5J2vYehf95QlD2RWsIo3ySvxOSn/+Ml/rAXi8wHL5BTnLU5CgUc0PHr/q1WYkhn+A3O
 +D5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779829401; x=1780434201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlOoT/qE+jmsU630R365P8zuAldHusIC0FuzQCFBsOU=;
 b=t5q11mXPh+MkRCPhuJHHHUxqYk7nbkGh7XS3bLT2P5sIcmmxfYLnwP+Wd4CcMZybLz
 zqrwwwndMISqcZRJyy3UOkEw2mxs7nxgpAYIkwUakzfjUYV4y6XmdkA6D+d31fgHDzMT
 yqZ08UnjJWVt5RHIq4u+gK/r44OtmMTmcOyPf+EiCp1LXsJIKef6hcLfcFdd6iuRMaUu
 kONa6cWiCuI468ucHtBwVYVwRwhoo0yIfSHiEGMnFQLXAOBUP/uIICYLfrPGTAt012jR
 zAL/fxCeSvq6xEHSbOqjw2VGkIxerpNaffQ6Ohd2+ejROp65MQMtYHRbltt5NMJWasjh
 qR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829401; x=1780434201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KlOoT/qE+jmsU630R365P8zuAldHusIC0FuzQCFBsOU=;
 b=HzxB40FWy6/zTcL/KJ8R9RccKG5EoV91kqe/EDfgizh9HMsydsZiiDBVxzLs+xCycH
 W2IG4hcdWIQHP5UuvToMly2QRfzTejvbgV0ectbtfHzPbreMp3VO3+ENxGXEj0AI6bn4
 7XNRuT3zFWwMSLOLP70ldExYDhm+KxghD0s0VNO5YacAfNoumu2cYBEE0adeb8pWu5WQ
 fh0zOIen1WtFJWxgx5vg6zPD+gvsQwFhK2PdXs9dprG3yjJuWblBfYOEFPdKVWBbCbb4
 6VQDsDul43BNAPwgeCX7hNUw8hNvCbA8R8mkBi7tIYMRDxORZvfa/p+NTMZYr4yCUVUo
 HROA==
X-Gm-Message-State: AOJu0Yx/LBBiLvl1OSkMhKPDMb/0/SNmM6Gcz5tB+Yy0M3Bbyv0KYsdq
 b74VZjBBFUeBYF6VEGgWP2XP4TB8smNdPLtgJellb6Tso5YabyWhN6cowZxKlsIfXZulVdM/Qd/
 anH9Ei/ryzZMpknZYCWCKTsuH/D4Z1h8=
X-Gm-Gg: Acq92OF64Fjoi9G21g/pMTlxj1eP5TkAv9/WgCJPozw4x2sACBaBirVRDtU//LKe8T9
 kQ/mzow9vxCSRIAOYl1hGNk3l0Z2CzWwgD8A/20YQa2PgimjIfCjxvn3fWaAympc/xp0NtrjxmB
 wYh6+NpfbUcDP8ke6omx6FOPgsQOK8tNefVfartX/elp1rq3gTO3DZoxnWqqRgvBKoeZqYnDCxW
 3ySRBMxAoIm5AT+q2FFFf+KakueNH3wv1XL+7cH5JV1P5ilQFLZRL11zrPEzh+lwaxvUwE3naNT
 fZI+NigLDbHhECJ6AzHtjIfsgm0uEU2Yh2v0QRg=
X-Received: by 2002:a05:7300:7c08:b0:304:8870:2ac5 with SMTP id
 5a478bee46e88-304887030d0mr4843030eec.6.1779829400374; Tue, 26 May 2026
 14:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-16-pbonzini@redhat.com>
In-Reply-To: <20260526175618.227743-16-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 27 May 2026 01:03:08 +0400
X-Gm-Features: AVHnY4LKJUeIjhVw2f3AIgx5tbCuDrFOxm-Ptmk-7EVEpT2r6AJki3SjoS0THRU
Message-ID: <CAJ+F1CLZj+5sC2TbrHoOXz91cqb-HGKpnEMmD5A40he7fG6Geg@mail.gmail.com>
Subject: Re: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindings
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Paolo

On Tue, May 26, 2026 at 9:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> +def gen_rs_members(members: List[QAPISchemaObjectTypeMember],
> +                   exclude: Optional[List[str]] =3D None) -> List[str]:
> +    exclude =3D exclude or []
> +    return [f"{m.ifcond.rsgen()} {rs_name(camel_to_lower(m.name))}"
> +            for m in members if m.name not in exclude]
> +
> +

Actually dead code now.

