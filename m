Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A2CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbGg-00064H-CP; Mon, 08 Jun 2026 10:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWbGV-00060q-Pl
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWbGU-0004ok-5T
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780930064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4+VtE5u1cbA1gYtQYcqvpHTrErJFhGyuZxQqOpMGXs=;
 b=DuwgNNtJgk+bHCZV7P1XewD/Q32KFwa1qeDUdoqihyrLnSJse9XvSni9WHYyvV1YHhZ3rw
 uZ4SBIUQrAKIUyZ44gFXOW8TS8VRvrXFrtERGjAbFr94KdXB0U3UXqyklad19Ywe+Zm6wA
 UKc89Ru3ILYDcgWKwL8s99wLU9M3A4g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-fhNBxLFaMRuAsixrgU8ERA-1; Mon, 08 Jun 2026 10:47:42 -0400
X-MC-Unique: fhNBxLFaMRuAsixrgU8ERA-1
X-Mimecast-MFC-AGG-ID: fhNBxLFaMRuAsixrgU8ERA_1780930061
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so2605234f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780930061; x=1781534861; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H4+VtE5u1cbA1gYtQYcqvpHTrErJFhGyuZxQqOpMGXs=;
 b=eCQmAE+q3kBJ7eq8Spqejtjgn24E5wBnDKuhIWI710vsQ/1x2CqdB2dChW1WaM9UMj
 HgamTWXwM9tDAqAXLohW+EoDpnlnLtf16t6c2Oy12AcO5vTp58wacqKUvtpTFfCi+JRY
 LuhB6a2SGQiVxwTWxzkx13Tg+tTswxJZEpBewbwENEbe0X/oEeemX88t+PaJVRTLu9gE
 iQW+YrygdAox0HKKezTzAELJR7mzf6esXpZ5UWEmBfYWShFcRasm8LKlCmQVIOKaEDOz
 viaotXJtW3QCAV6GSbShsvIkeBL5mYcdsMyX1j6aapOngIgnKkovA90nI8RmoBaPIVnd
 W6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780930061; x=1781534861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4+VtE5u1cbA1gYtQYcqvpHTrErJFhGyuZxQqOpMGXs=;
 b=BmwuZGGmi3w18BVMsRbflbxIiiqTyv64XnKlhLLajgGjXJ5CL2ZJEg7V8gMZoJiqIY
 WuiO9KNMBoEOvvwEUUPmL6hTkETxPMqZG+vvTSijNA7TcVXlA8ftKqYbz/jHc2BUuo+q
 ViwfpHTuzuLcyURYgJDvych8qE0UFy648fTJ7/1RU024e+pq9JMGfCG2OiXJTW8aZ0MY
 TSS/kaFQ7Xm4ko//0uBcVUd3O4C8WHeMGftG8GZr53ruSHsvQEKlQVT6q+ZkuVrkDZwY
 wtRosMWDRp1cet+Nmrf0oZJAOlKJNUGYxyX316U5ykhz/L9vvVmwpYKOjl1nhx7D+2kr
 T6sw==
X-Gm-Message-State: AOJu0YzbQsMtFErZrTN2msJSvGB1yEnvf+jlpGCpX8a47NiBddxmwqn0
 0CYGMZg7UmugfYbsqSaf+k19v9FE9FLAqoTc6SA7yBT1xmzye155h3EcsrWXY7h4icR5Ft8ba4R
 Qmms5Cc0KZw21eT330ZDQen5mWIGWEiSw0anmOKJLKonqE2L0hNl9USMX
X-Gm-Gg: Acq92OGysugBRY9fA9IlRPdCJ0L6jyzQFawuNytzzmVeCTQ4q5UEoQLxgaG59PeOBPJ
 yEAagHmNr6wV2LLPZpi+oPD2uOTIwsQ4MOsAjs+f4ZEuKVLhC9L1ZdWc/rKtDYMFaWGxlauSr3D
 r5zWY5KBDSIOTEnv8vZRj8yTzyhIn9Q76DATwuH0MXupjalvVbCAELes0Nm0b2t8SngKKvK+Fyo
 VYffS9fdq/RwtM4l1AEGBp0Dtlz0hQZYDd0dZInVycG07jFbGXpz5VWOndd6TGvjolSRq41R/pS
 QDlIXvf/8XLQQarUw5kuovJqAxI+nBltTkd7zITU/1QT3PyA76qpxLnflags2ERFv7o+ZSadirA
 JPAFU0kM7Ng8eqt/0iEldsPned/cwpNJYECEyBFXHnMp4clqJV1pdE5JDduOW9YH4cmB5Yw==
X-Received: by 2002:a05:6000:25c4:b0:460:18cc:dcfe with SMTP id
 ffacd0b85a97d-46030621869mr26955359f8f.34.1780930061293; 
 Mon, 08 Jun 2026 07:47:41 -0700 (PDT)
X-Received: by 2002:a05:6000:25c4:b0:460:18cc:dcfe with SMTP id
 ffacd0b85a97d-46030621869mr26955283f8f.34.1780930060815; 
 Mon, 08 Jun 2026 07:47:40 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm54440508f8f.11.2026.06.08.07.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:47:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:47:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
Message-ID: <aibVr8P3xtxb3oQQ@leonardi-redhat>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
 <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
 <aibDrvcHZu514FeF@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aibDrvcHZu514FeF@sirius.home.kraxel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 04:11:56PM +0200, Gerd Hoffmann wrote:
>On Mon, Jun 08, 2026 at 11:37:47AM +0200, Luigi Leonardi wrote:
>> Coconut SVSM, with the upcoming device tree support[1], will use
>> the IGVM device tree parameter to discover virtio-mmio and ISA serial
>> devices instead of relying on the fw_cfg interface, which is
>> QEMU-specific.
>>
>> The IGVM parameter handler is implemented for the i386 machine
>> target and stubbed for all others.
>
>Hmm, why?  I can't see anything i386-specific in that code, it should
>work just fine everywhere.  For example on aarch64 (which is not yet
>supported by qemu but already in the igvm specification).
>
>take care,
>  Gerd
>

Right, good point. I think this function can be moved to `backends/igvm.c`
directly, so we'll have aarch64 DT support for free.

Luigi


