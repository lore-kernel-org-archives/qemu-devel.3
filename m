Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B87CF45AE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLLK-0006x8-WF; Mon, 12 Jan 2026 12:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLIB-0005tz-JK
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLI9-00068X-Mj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AldCBaYJel6HxB+0CQVjj0wkO30xgddAEo7L/RnCjX4=;
 b=auY2SH8LNXXU1FMRX0tbGPM/HQZZZFU6lINz3wKyHIq2KGgiKb+r1FR0XznYQUgL235dsp
 mMdP/J0Zyiu9eolbUvNddMnIBfSdcpVWNKY1/y/dBma2fR5EX0R4dmtdC4jcNBoQ9VguUF
 SIa4u5BgeLrOqkxeZxR290PUzW4GxXg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-6MSGW3GvO0GkPR3qicvSUQ-1; Mon, 12 Jan 2026 12:01:18 -0500
X-MC-Unique: 6MSGW3GvO0GkPR3qicvSUQ-1
X-Mimecast-MFC-AGG-ID: 6MSGW3GvO0GkPR3qicvSUQ_1768237277
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so4889468f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237277; x=1768842077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AldCBaYJel6HxB+0CQVjj0wkO30xgddAEo7L/RnCjX4=;
 b=RQ8gxNDDlI9T66RobOam23Lh0Rp+O0YFioW4T16z0kFaqezK9kzBMuOXu2LR/uTD5Z
 jr14KShDbIdazDFRJi3O5vEUzEZYgrwpKkoR6NNIVEqIWaBg0uU3cOFBCS4VeS2ZtXyi
 corZb4fN25ZwMWPzbjE6CMDX90f/hFL6G7MezKhiv9C94KrjcSYLVRIuhFGfgOY6Ijoh
 6P7uafi4I8cumxMSyg8Bv0zV1fd90lN/uTIjLniQD672sbCuKr+uu9USYv6JTaORM3ja
 Up82ZbR0CG9R79dabJ4c5VGz0ou+y4tW6xujgos49XOLDtKcn2Qrl7Xpyz2lTZaTLa29
 e2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237277; x=1768842077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AldCBaYJel6HxB+0CQVjj0wkO30xgddAEo7L/RnCjX4=;
 b=n+0AtAES6Dvuf2JnPhzs3AYtmzJlqXPtWh6ILyQyEkbI+dVDv+3dVbByJwRek8HW+b
 kslfSRBi+laBSS+z1PRGRJ1nqzMB+8l5lT26PGlz225zBoP2i+zAke1aoSyNIKSo4X0g
 C4OThHsBFw1NE9uLMBqKFAKNCy0INvoYjgMLUAAt+6Hvl1ODT1mEZ0JpC8lofYJCAirv
 RJ4gucSKkk+PGlc8sSr5dADneUQTgQzTmJjEiw2W8XFzMofjsJ1rQ9W3l0owPWJbDf5A
 z7zndcvsX4n42JR+tYv1Lbmz5wY0S7fSS4NNaLHVaMcyOOlhWiFMfBkYsdFuwe9CCfrp
 PPnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUU9sosuxkmZye1LmN7BKUnA/Qx3QQ0p9zhA/5m4xpn0OiIj3g/gDOAvxYwI2qZee2eZH+oG531cNA@nongnu.org
X-Gm-Message-State: AOJu0YwL1Y4HPBNALzdW8b4n7z6JfYyk980KdwacffVQRkt+6MP1EGnq
 q1bQazLbDPQPz3KpMsGb2uK5HH55wNv08XYw6yR+fMR9PXYsTkNCiyH1PQT62dnLE20++Sjiy4W
 RzNijbcaoOlyidd3FLg26YpVS+3TzOL+mTLuwyc+ww+j7HPARWgpQZwr4Z/UjHZv19jLJNusZkf
 eSPFPDt/EVqzFV8iUiuU17H/Zht5suJ4s=
X-Gm-Gg: AY/fxX6w+R+0sFWEKbigvPOenqup918whJLLas97effJ+LvpPJA/r6XaqYiKkSUw8er
 9zpzAOHCXAzzT2i4/5T/3eDtdfy2IE03F4vzBXnHTlVEBwB4Rzui9HJX2NU0gimmCA63oo2SCRy
 Kl948SkeNLwMUGn7M8bthWk4j03lxnhLg/3r/2CNcPzsl5bfgpcvuklSeYkdHuiYcr/k6JNyjLL
 RRawzfYCi2o07GLZBU1TpN3AgyKLHYoPMiwSRd+wFVs4F2Kg65x8Y9CtrMSFRK9XzCvfw==
X-Received: by 2002:a05:6000:3104:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-432c37c870emr17720922f8f.34.1768237276997; 
 Mon, 12 Jan 2026 09:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAiYfjnr+gYdtjsO6mWWQ+a+BH9XfzWG3kpFltGJWfx1JU+oZ6aKStp9mLHs0yv0OictNdRBrZnyrHEsB1/Wg=
X-Received: by 2002:a05:6000:3104:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-432c37c870emr17720877f8f.34.1768237276561; Mon, 12 Jan 2026
 09:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-3-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-3-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:01:04 +0100
X-Gm-Features: AZwV_QiH3V5FSKAnNtBPpx_JZBXYR6rPYd5poD1efJhVE8ZMgP50Mc7LrPQ905U
Message-ID: <CABgObfaATsV8ECm+txeVzg4c=5wjKgBR972sLc+Ejw0q=nH+Fg@mail.gmail.com>
Subject: Re: [PATCH v2 02/32] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
To: Ani Sinha <anisinha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
> +    if (current_machine->cgs && reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET=
) {

This should check (I think) !cpus_are_resettable(), instead of
current_machine->cgs.

> +        if (ac->reset_vmfd) {
> +            ret =3D ac->reset_vmfd(current_machine);
> +            if (ret < 0) {
> +                error_report("unable to reset vmfd: %d", ret);
> +                abort();

This should not be an abort, but it should change the runstate to
RUN_STATE_INTERNAL_ERROR.

Also, I would move the introduction of
confidential_guest_can_rebuild_state() callback even before this patch
(see upcoming review of patch 24).

At the end of the series, this should look something like:

    if (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET
        && (current_machine->new_accel_vmfd_on_reset
            || !cpus_are_resettable()) {
        if (ac->reset_vmfd) {
            ret =3D ac->reset_vmfd(current_machine);
            if (ret < 0) {
                 error_report(..., strerror(-ret));
                 vm_stop(RUN_STATE_INTERNAL_ERROR);
            }
        } else if (!cpus_are_resettable()) {
            error_report("accelerator does not support reset");
        } else {
            error_report("accelerator does not support
x-change-vmfd-on-reset=3D...,"
                        " proceeding with normal reset");
        }
    }

Paolo

> +            }
> +        }
> +    }
> +
>      if (mc && mc->reset) {
>          mc->reset(current_machine, type);
>      } else {
> --
> 2.42.0
>


