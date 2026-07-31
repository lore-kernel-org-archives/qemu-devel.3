Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA5C55162
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 02:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpdDK-00079U-Ms; Thu, 30 Jul 2026 22:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpdDI-00079D-Rf
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:43:08 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpdDH-0008CT-As
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:43:08 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so59974966b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 19:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785465786; cv=none;
 d=google.com; s=arc-20260327;
 b=jJTpQoHO53OjTvRjGTaYF8kQ9Gj7sq6y77rqgvMC/C3TytqPBmbc4x8aid1t7FwC3w
 yGBsd1q9Ue28SF+VMXXfHTHOLCP4LUZuMHoA3mkU3fvGdIFnyfzyUOsMOeoprvh3ZHt/
 GnTHi6MVrjUN2pP4Sf8BlMVDzL3CBMPU44ZtGqNgYGZ8+s92XU1MdCf01xpKAw+szCKY
 fGERr7deQZYl/RmZFYrXbDhIROnSuQkgiyxF/3C0uG0D8tbzk1vQwBFg3b+gzGm3IvsR
 m7H5ly8weAhTh4gM5umctvzlpzaLW7XBUZ7M50kfYAFHqQXOqyzAPwZg8NWdmJ9Jdv2D
 vp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bhQB/HICxY8R9Yh8GHCryBEw/RtliBXvjrO0Aacn5vY=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=emPBoNs3uEOB70/IZB3lF4aDqbMXI7nQMQKYfQw4/HTYxcPKbEqy9Nk/O3ceDfNv7b
 LiAgm99B3EbvbsuurKfYhJFLC8E/UDomxb6SwFX9BTRkdQc20LR3bZ4cpy4dmn/ViniW
 MAxHb6EZ8ackKFsmJfpMGiO/lyqhO966o3Qsz3bIH+Kc2wVW2vX5o7l+bzlJ8E/Duxyc
 oMF3IxfoqhppSba5BcqD+C1PTGCW2vUYFj5G+UAYPH63B7pwSpDi+tQtUFGAeqxtKRdv
 YRMJiuNXAlRz72Mog8sqlmdG/aJ30Wy/pVoVc2fws+PIB0fv4BbNZIDGEKYsfow3dfVD
 dv1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785465786; x=1786070586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bhQB/HICxY8R9Yh8GHCryBEw/RtliBXvjrO0Aacn5vY=;
 b=eveYRuw2efBk9QYmVtF66N1gLmr1vk3+U3KD5PxplefyvaEGD/8k1EnK/+gjCP1w2n
 FbCSjtRvQQUtMRyRd7aoEx34ZnvezaCRdtMXQneWIZKdLeDlSM9cTnTyqqoojVbkl66d
 jpkSNaiKp0GXEpja0nJIFHaozJdFZP6p8hmgmC26wgj/yxl1BapK4Rh8uMAH85eNm/3j
 8Us9mlmcaCIEU7ym1fmFSwMyQDEv3AHSwomuz6IBhljRXxwIysOx/yXS58rHkYFiHXSV
 l8YET6dModnQYi8ad7qJtgJMIiVnC/V008JDz9M+TFYbG08T7sLBCqZrameWbkT7m8Rb
 Fsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785465786; x=1786070586;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bhQB/HICxY8R9Yh8GHCryBEw/RtliBXvjrO0Aacn5vY=;
 b=Hfgx6jSoBn10CLm3Wso3bUZzzaTy2x9lYTLwS3ob2pHncnYapSPZ8hIcNTxfr6NuDD
 MumMx6/s8NQCfGwPHKjovlBobWJ1UA49lRtwDhgLD4O2xMHJEz+BAT33DL3PH5eVOvvO
 AmWTJ2H9Jc2fV3wXCktQkOO+AAJ8ZGHalXQnCihtuRCz9/MooPnauEYl5Hog20leKh6H
 mxNKxwCG965vxQfKJfstl5uHG2dDJYmsRnxkOkh5+xr9Im/3+wKkWcEkPxPZVE0qqPQJ
 Rk/+UM3FDc0ahEa640TRh38/BGge84WJWkOWWht/QehukygjRyQXnfOZzUp3fMgl/J9M
 p4LQ==
X-Gm-Message-State: AOJu0YzVuHjV82XX290TkSUV/e4vndu4jb7jwzxP7YRlTwp5mshb/ZS3
 JqACA4WESqsIcvdBHwexR7wUTERow2PORJuKNh6g9tTnRRyDK8t89HQqba1/BvmimAhSX0kT3es
 ZAv5hR3oPe/DzFUmdBnmp7knOwkoah58=
X-Gm-Gg: AR+sD12a0RayarLsbRBQkdEUZV7J492E1aLORimJa7uxRsKim7130rociLzSJsW91dc
 MQvFs7sbOiALvhtOClUECNZn9DXnRz8fO0vrABx/hAtw10Y/wJYqiod2DuwQgAyzPdv8BpAsfdy
 jj3sm/7gwexz+Z0lRZEN5rqyUPhKTnPhf1koeJvBUeC81dGEunPS/9NBjWbf66YHlkYHkFMCuDg
 eOzZBpDLY8AnFVLKBYTmJGyXvx9HeBuZISToZpzZecwx9HOtlqgUapKqSccIZHkD3B6tqRl7COs
 3xnDv4Tq7g7tcvrh2LNPbbsqB754E23Aop22oUoDVQAc
X-Received: by 2002:a17:907:8908:b0:c19:6117:b2bf with SMTP id
 a640c23a62f3a-c1fd28e5b6amr9361066b.54.1785465785534; Thu, 30 Jul 2026
 19:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-7-zhangckid@gmail.com>
 <87a4rkplof.fsf@pond.sub.org>
In-Reply-To: <87a4rkplof.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 31 Jul 2026 10:42:29 +0800
X-Gm-Features: AUfX_mzHz8PmTKb_AyhpixP2kW1KouzzklZFGbe14LLIdeTPLmndr9N9f10J6rM
Message-ID: <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 06/15] monitor: Update tracking iothread users
 with holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Based on monitor QOM path tracking iothread users with holder.
> > Introduce the AioContext in the Monitor struct to avoid repeated calls =
to
> > iothread_get_aio_context() and ensure symmetrical ref/unref during
> > monitor lifecycle.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> Why are repeated calls bad?
>
> How would symmetry be lost?
>

OK, will add detailed comments like this in the next version:

Avoid repeated calls: Under the holder tracking model, fetching the
AioContext increments the IOThread refcount and registers holder metadata.
Dynamically querying it in helper functions (e.g., suspend, BH scheduling)
leads to redundant refcount churn.
Ensure lifecycle symmetry: Storing AioContext in mon->ctx establishes a
strict 1-to-1 lifecycle pairing: a single iothread_ref_and_get_aio_context(=
)
in monitor_complete() matched by a single iothread_put_aio_context()
in monitor_cleanup().

Thanks
Chen

