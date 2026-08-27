Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DF8C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 18:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzeO5-0007CB-1f; Thu, 27 Aug 2026 13:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzeO2-0007As-Ut
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzeNz-0006Sk-Fo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787853574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5tvMOgDlNPcG4RJ6rTsz18cC0h5UV1jgNVK5VwBpRU=;
 b=hFCFuR2O/ApM7GDoPBCkIZOXCitkTiTOQxqS7nz2LAycq9zGYF/LBww5Xgho5+pIeefkuV
 WuO+KIJVTD+Vp4uRA8J4OcqW3MRUgvuKT3Culf6aVenT7zgW6L8Tg4AZUMWBYcORAbprYS
 VcqWXJaJJHXULgXty54lrXpaHgk4OOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-SvXiB76eODCHWc6r-Ajymg-1; Thu, 27 Aug 2026 13:59:32 -0400
X-MC-Unique: SvXiB76eODCHWc6r-Ajymg-1
X-Mimecast-MFC-AGG-ID: SvXiB76eODCHWc6r-Ajymg_1787853572
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so220085e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787853572; cv=none;
 d=google.com; s=arc-20260327;
 b=lv5WbBhGQ5U3LdmMElwIerXs70EsXRBbbrkyEjrCtF6dwC5MsEtvwjzuN96YyTE2f1
 clskAI9shwAW10MKhYuit5rrm4TMYd53do8G4d/xQmLUB4GifPj7Lyswv6LF/bKuimmj
 YiiwnnuX+7jrCpQQ0/RbP/C45Q4hJ/PZabPEzdMg6ZNGPiWumMC/GBrXXlls3te19vAl
 xNIub23sKDwUhps6lf0vo7B/468Z7cUdxdFKvi26h11fBORdOOupowehM7iH57yfXMGc
 pGlZyGV478n5tn7Av38Ey7fTxFeavVAd5BZ/A650vvYF9OeucZSmvMeTzCLvPSBTu/G6
 lrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y5tvMOgDlNPcG4RJ6rTsz18cC0h5UV1jgNVK5VwBpRU=;
 fh=/VAcVfS+dKqTQuo70067OY/myg+iUnDAze/+gRoqrCY=;
 b=Fm0NUjc7Bj4VqRbh2r8WRlEOow4yA3URVg6hR2vr4CJOVBcIuKhO9Mk5khTSvbedM7
 o+nngOZfsrhp7RyD7o7Yxs3X15PhP0Gx4EZyOFOd1mJjIZ0ujTcj537PAi8FPKXq1Snw
 XSJZDchJpmV35MQ6HMA5mqhJokgjgyi5wffyTlAxiqGbquKAGyoQEHpgC+WyXoElhpF6
 b9Fdg7Qx/Y7HSHKABunM3DbJm1kf6B1o7t7yGefbEfJQ50CWkO9syW0n/Pn7ABxdBVqK
 mYT3NZGEyNUebsB/DqHaxcAr8H3jm5i9MHtuvGYyriMp8vThjhwAUk/N74QVMGLY93ei
 fXrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787853572; x=1788458372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5tvMOgDlNPcG4RJ6rTsz18cC0h5UV1jgNVK5VwBpRU=;
 b=m40o4Br3GueGsCK0uS30enBVrB9Bp60hlCs0z5aTef3HhIpXnyj+rUwgoln0MI2SpL
 ltA8beMmXZQDaYP2x70FN21bwmanzJvUHKey29xaU8ryMv6iNtfNbt818vjKeCKx0+I4
 b9dVbZeWQCJ8+3dwbNVwExeMmOjW7saONdra12zzbpO8DYuplCf09JSMWEJ2kBOLB1UZ
 jIISHgTzSWwRjwEhCvxLKSZoue2JAwZOKfVYvF5A0hjRXeg0Hwniko+u8Ofv/eup4QGG
 o300vh+c9/mIr15gVr84USeCn3Zwar4ys53e7Yr6p8/yTyd8TYVDHQGRC+jHMfk0Fr5G
 +hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787853572; x=1788458372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5tvMOgDlNPcG4RJ6rTsz18cC0h5UV1jgNVK5VwBpRU=;
 b=fr+QiKt471/53Qql0kfAeUpQy4YyyiUN7Obq9/zBLU4NRzfi3xZ3OzQIRDAiWpwOID
 zpoSbc4gcSnAxVLalaF6ltV8G0FSRF8TtNZJyX5fTf/CT2X+CEriWLbG+242tRKaHtnx
 IIHLGpKPE8mdpmN/+7D3/26JfK6Z1zY4HHS5L4aK5osqIBmhpReZ5dFKbkZTA9ZV0wOY
 BEcIdDGxnZnBTro+Zry9M8HkAUH6KymZjEm3EU91JQWnvP5WZS8b+OdrHgEDUkaHar3e
 4AqLQEcO+MBb0FyNPI3mYiSp/QEkpJap2TpHU0KR6V5lixktSnV78dasAxk02ZPxjJsG
 6Bag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUMYQgfTaG97SJfFhr2tB/ybAzmrEdc6/Kb9upfT6WUbbG5uy0ya0bJTCum9J7D1mVwXZ5Cf37O56T@nongnu.org
X-Gm-Message-State: AFuF++mlIOpS8SpVyOrVodaVFqQABN207y72CzxU01DU2EjLIcaSIMoU
 plx1iEDsZxwmtaUpPHcF5C1cX9s2FLfF9OxpN9D5B73Z+UHvVzxB6XSXj4VVe8QROXdw7/oxen/
 98CzQvyjY5eDXYM1mi4QO42szDjxXo1foKR1xDnbp1BOAVWRXbW4JDvOhQtV39CJ/rg0DaE6PUT
 3ETME0dSPlmZ1XOgAEYtggT7lll3w8Qjs=
X-Gm-Gg: AR+sD13LLoWTEHhII4FKoUy3CYkwN0SzzDlyqEs5jyAKlWFUlvNRVi7RO2KZgf2ihmW
 ZkKUiPlc5MFxSmHJzqVylkvPGGZ6bIuEEU9IHjTC+XxnVSqE/k8bJT3LFyvTLCo6ygRBBrDoNim
 2FHLhjFTtsQoJDedAcsWGG1yr7oWF7IfFHJ5i2ti9iMT8y+OG51GJx+Da2rQRl5WtDFeqt01jQ+
 3XQwHPaMM0QApAirXyIcBCKGLpFtUe/53sZkZ8Xo7l1kEZTpDcaSlYUdL46
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-482f782a4a2mr988169f8f.0.1787853571686; 
 Thu, 27 Aug 2026 10:59:31 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-482f782a4a2mr988102f8f.0.1787853571294; 
 Thu, 27 Aug 2026 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
In-Reply-To: <ao7c-FiawF9sMCGj@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2026 19:59:17 +0200
X-Gm-Features: AcwNN1VpaapR05HRvOFF4orkVX2TS72Y3gXl8WNsZU1FMiT86DpM1kMM4s_3nag
Message-ID: <CABgObfa4QiBKuj7o06RL+egm_QOX03hpP9PAHoeKYOr9wwGvFA@mail.gmail.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 26, 2026 at 2:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> With the clean break with the past, we also have the
> ability to tackle various long standing design mistakes
> present in qemu-system-$TARGET instead of carrying them
> over into the new binary.

I am not sure about this. Overall most (not all) of the complexity of
command-line processing and legacy arguments is kept at bay, and
contained within board code - and boards do not have to support it.

The complexity that is left is tied to -drive, mostly due to
differences between hot-unplug in -drive and -blockdev. And honestly
I'd be very much opposed to dropping -drive because using -blockdev
correctly is *extremely* hard and barely documented.

If we want a clean break, we need to drop the command line completely
and just have a QMP monitor on stdin/stdout
(https://wiki.qemu.org/User:Paolo_Bonzini/Machine_init_sequence).
Start small adding just accel-new and machine-new, and add QMP
equivalents of command line objects as needed.

That said, I understand that this is just an idea and not the crux of
the disagreement.

Paolo


