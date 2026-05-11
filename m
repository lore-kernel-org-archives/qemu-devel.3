Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44025CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRmp-0002FL-LA; Mon, 11 May 2026 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMRme-00027R-7E
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMRmb-0007po-7s
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778510330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOEitVMnSyqlLfcT4u+KtrlDontK763JcPjnYuoYSAs=;
 b=IvJ4IDRN9VVMcTpDtX2PZpkMa6HnDVgKBCfKRWIKuMtirI6Px2o/c8ZOhdS+ZnKzfcXcVz
 mC6fmqfz9UJTDEiGko5WtEfRWFvR1xsZ4JRyKzt5X3CGzC/ESKbB8Ja9/5Xts7WNWvvZ7w
 hMctFRQLXxl/qWpApuLNKzY4MwU0PDI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-IGyNmSsNO_OjC-oY3sOlHA-1; Mon, 11 May 2026 10:38:44 -0400
X-MC-Unique: IGyNmSsNO_OjC-oY3sOlHA-1
X-Mimecast-MFC-AGG-ID: IGyNmSsNO_OjC-oY3sOlHA_1778510323
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ecc96a9aso46451635ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510323; cv=none;
 d=google.com; s=arc-20240605;
 b=HlrHpzew1w323HqDGJRRMtHP1DDipde46g/K3TZduupTmneHD1auXIdi2+eD9oK+de
 +UgA/a4FPfp0VbRVst7A+sYDo9hVhlvgCPxv1q6myH5Xd4aedOnjyl9r+l2Hbu6WmKcE
 /i1gwjDyBv1fBxNrYJuJYT4jbgIT2vI6yaHt6+d19HPMHER8NjV7hsvOU3pFqOlEnegS
 lSsp1kyZfvIh6udnRrL6TokXfqZU0k6A4s7cLCt2K77e6j08XkRfzhFYPPR2ohnlV4PO
 Jeb4EE0pKllIsGLvwHcqhYJS9ELkkhnDMbx5tWY4aOdTebER3lFp58P6easGBdb3WSoq
 Tabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dOEitVMnSyqlLfcT4u+KtrlDontK763JcPjnYuoYSAs=;
 fh=DE3UAGgJF/+n6TrkTSdcpdsriQ/+3DQh/puSSyhh71g=;
 b=R6tE5GFj6lWs8D44xukTHyZ7D4bVw1Mjw2r2Zb/cxKQR6KHuCts0uRisQ05BoZLuFW
 AvmrPcvvUZjVmIdQjfwKGu51aA7CxDKjLM5D01ZHoNXEt4A8YHR2lTCg7z6xdznqNBVh
 ZBNUMXATiNuXRvsEknIEALtlc1+9Sn3F3d3BZkhxotmBPrN3MN5TWMGHFA0ToKPPniwV
 BW9nNjuyKxBHnZn5hGMod0HLALotOjZyivPnZzXo3CBiiLpIUmcZBf572/vDINBtcVps
 voKJYQm+ve2H6UEGkiJoQ8V1MTLvauO+93yMM7AZ/d9GasLIpIUVepBah2IwUYUVxGu+
 RvEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778510323; x=1779115123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOEitVMnSyqlLfcT4u+KtrlDontK763JcPjnYuoYSAs=;
 b=PYAOmhJls07TcH7bG8veOYz8ic7XYFG+4hykTxPTRVOQQVOaO31V5wQ8fygqhdhLgy
 x6twbg007Z3XUIfpRkkBsTvRM7YQNQdr+82GdZwUCrjoqU0Oi0ZTRG4aGjoNFYR/tjqp
 VfcyftguVUo43AcA1/GdWQwSUO/QT21Cz/T+ncjmmzwdtEGJvlVdp0WHl7lXLmNZlj68
 53axN0X4gvSo0WgfvITAbN/dHiB3V2Ny3FE2+1EaE1R4v106fXnI8TpKPIfv4Mrp0LsZ
 Y4tRYt6iLxgi4HRCK9rlQWKvQROpDlD0XUBvlxC3vUWhpYBq5H4f4LocmIy2Yv/LmF1u
 +LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510323; x=1779115123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOEitVMnSyqlLfcT4u+KtrlDontK763JcPjnYuoYSAs=;
 b=DJXctMCYpR2NyKjV4x6oQ+ZofoAZzWz9arKTvXEJb3uyZBYeutsttt6BO9khwIiOXG
 2o20+/n13r6dyaXWMGelar1Gw5EKmv7kvDwuayaM12i3i3zNtxQ7Dkjf533Zw9B8vjJA
 Q5HwogwccwtPYZ36WiZCJV8et8EmwFilGNVqayw7b4Kzk4mhxFU//yGkDZALcr/yU5VJ
 ltjpVmdH2tpOlm+c5cgo3ZzJHt2ydQ9/WEzCppCukke7TLr/HcInM6bV7YgHsVU5X0ml
 /Bx3FESsup30RcOIch41arCqsLRs6PuzAFd1iodNxjhQyW9AlZi3En09FwdVrE4Lr0L2
 zf/Q==
X-Gm-Message-State: AOJu0YwKTyf0n/3opDFOok6r21WySHdD0LwAyCqT8yFR8M916pN+qwtW
 HpMAiMLYyPxLlimGma9dAO8MWr8qtwhoNxGJpDnxU7nbstjflsrr0GIyerqfUFrsXfuGMUFO0Yk
 XC2UG6DdBkBT4spCRNXBJdM11OOJTsoh4Gtcxfn5wkA2XaabXyVFVpV050AagEtkOBUVXPax85g
 9PtuNJ7cpjyDGO5dZR9Kk6YVfv3/rXBlMpHKLN7zdbsw==
X-Gm-Gg: Acq92OExHgnCxui40t9T6B7VLXDZGXRsWMm8/+zs+3f4zN3QJ6PFHWTqFFdfP4OkTpv
 w2BWsb5JGBtlc2sPBiC0vCIY2s8Rf1AY/J3ljVaPhVGmi7FpmEieK/CXneRsf8wrJciXZBmwD6j
 75dFVmFY0Rr7hIrkD+67qCUE1O0iYYPICWs5U/TDKqg15H4V4r3DWEWyMZNT4JkHgujCxUEXHYE
 swlC1E6XU8kr6Gfuh5+OM4HgGcQCkF5VybvxvCIBHbK17qytuZTj/Vs9C22lJInduftYrhVNjaa
 RIKDqi0R40DFCEe54BzkLuA=
X-Received: by 2002:a05:6a20:914e:b0:3a0:b65a:5df2 with SMTP id
 adf61e73a8af0-3aa5a939e83mr26214433637.23.1778510322957; 
 Mon, 11 May 2026 07:38:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:914e:b0:3a0:b65a:5df2 with SMTP id
 adf61e73a8af0-3aa5a939e83mr26214395637.23.1778510322519; Mon, 11 May 2026
 07:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260511142219.797048-1-stefanb@linux.ibm.com>
 <20260511142219.797048-3-stefanb@linux.ibm.com>
In-Reply-To: <20260511142219.797048-3-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 May 2026 18:38:30 +0400
X-Gm-Features: AVHnY4I9f5yojhsVM0sZZw-1lYFPnknMbwJOwq-C7DUGLCGfLcF5OtpGfz1jktw
Message-ID: <CAMxuvayD61QtH=ZH-eiRJKsGVyNsnbBWWjXp-GMqO9UuQYsuUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tpm_emulator: Disconnect if response exceeds
 negotiated buffer size
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 6:22=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> Disconnect from the emulator if a response was to exceed the negotiated
> buffer size.
>
> The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
> currently no TPM 2 responses using this size of a buffer and therefore
> no response will be sent that is exceeding this size.
>
> Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  backends/tpm/tpm_emulator.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index ac5427b84e..95d2de2f48 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -176,8 +176,10 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tp=
m_emu,
>                                       bool *selftest_done,
>                                       Error **errp)
>  {
> -    ssize_t ret;
>      bool is_selftest =3D false;
> +    Error *local_err =3D NULL;
> +    uint32_t to_read;
> +    ssize_t ret;
>
>      if (selftest_done) {
>          *selftest_done =3D false;
> @@ -195,9 +197,25 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tp=
m_emu,
>          return -1;
>      }
>
> +    /*
> +     * Size of response from emulator must be <=3D out_len (=3D negotiat=
ed buffer
> +     * size)
> +     */
> +    to_read =3D tpm_cmd_get_size(out);
> +    if (to_read > out_len) {
> +        if (qio_channel_shutdown(tpm_emu->data_ioc, QIO_CHANNEL_SHUTDOWN=
_BOTH,
> +                                 &local_err) < 0) {
> +            error_report_err(local_err);
> +        }
> +        error_setg(errp, "tpm-emulator: Disconnected after receiving "
> +                   "unacceptable large response (%u > %u)",
> +                   to_read, out_len);
> +        return -1;
> +    }
> +
>      ret =3D qio_channel_read_all(tpm_emu->data_ioc,
>                (char *)out + sizeof(struct tpm_resp_hdr),
> -              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp)=
;
> +              to_read - sizeof(struct tpm_resp_hdr), errp);
>      if (ret !=3D 0) {
>          return -1;
>      }
> --
> 2.53.0
>


