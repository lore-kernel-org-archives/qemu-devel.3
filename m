Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C47C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyaJD-0007pe-PZ; Mon, 24 Aug 2026 15:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyaJB-0007p7-G7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyaJ9-00071Z-Vb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787599571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szFVNRz9EVpTtHVynfbuGdiNRmMrnEhadaDH6fzf/xQ=;
 b=CsgeqKgtSGuOHpdEp7hdMMXHPoBqWxyUqK8TlGISebv/DXQn2amAitE4k64X70ncbZatb/
 sQeBUjCB2ZGNXwAa9E4fVY0xKnDv88MDGXvhWKs9x3NnsPneHbsW25LI7fdRmYkBV8Y9F1
 +YIqs13VDCtob+Wdy2BkAQ/SFQHwBFk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zqS27ZOTMMq3RsYspzx5Kg-1; Mon, 24 Aug 2026 15:26:09 -0400
X-MC-Unique: zqS27ZOTMMq3RsYspzx5Kg-1
X-Mimecast-MFC-AGG-ID: zqS27ZOTMMq3RsYspzx5Kg_1787599569
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e934385db1so44802346d6.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787599569; x=1788204369; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=szFVNRz9EVpTtHVynfbuGdiNRmMrnEhadaDH6fzf/xQ=;
 b=a03pfUxjE9vZqVuErs7hH3bl0a6MWme7BjckRqBEIYNk1Fruj5r86Ml7wQEn66iyKy
 VSm+X6OhVHTjVC1FJCfgy//l+691qqzj0rSANGz1fljQ/GD1Sfn7VRmy/Ain77jucSEe
 cibIuC7x9um6UnWxvoBQkKPwsie+wKDW8JFNWtd75tB3/+QQSEJj55mF7uTg+VmS5jYH
 MIvhlYDiMYoynIPEKW2KnQU+bxrpuz8VNUL1IrJ5QXzCesZ+IQztZWEZ09I4t5qP7+yp
 F7Zg66qghrt9GzT2R76spmp38AhtfWLpqAtVwKP4ruu1r7wTRphAw2rJ0At6r+EUzAAI
 xybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599569; x=1788204369;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=szFVNRz9EVpTtHVynfbuGdiNRmMrnEhadaDH6fzf/xQ=;
 b=DkRCVFSxrV/t1vw4HKnURivRZf36Ypp2/3E6CWPF8rP9SYQTxFtH/fz8G0y8QpuuqR
 E+8hrIJX/m2NL4bjhzQcwN5NVxmcSQMqrlnKSdxBpv5m9blYmmDWW9ly0pC7fr2exZfm
 yhwqai0oxmJPHs2pUepLJW8yzJ0CdWwjG+b+uP/gaQu7msKqEbJNZH3LGnsA/kQGi3ER
 G7FrTcm5Ww9NuGV721VkoUmNmcziJR2hM3TNnrS48oqw80JLf/Gv15SdT4GflYZrK098
 90tf8AhBqPC468zn9Dptt6SnWmjlJq62BopY5NeaTdgV45WzI79fBhv2/vHPUlCerD+h
 fwYg==
X-Gm-Message-State: AFuF++kvAJfoo2CzEoFEcfd48OLcocEuGb4QELqVudsG4VXoBquM9A6k
 KVo1y7AsyRAJO1XYI+JsTaYZHV9U57q/RiCF9al8XXM553lAnDoz9qS/PGoZ1v1pxo9pUOXjsMB
 cf4LYTmM3deDwKsbuejHBAMYq6gpDTTJwjK4I+1jMVkFpfz0tAGPW6K8krY9qMNF3Zx4hmRIdhb
 WzgwuWLw9WbW5YJdDn9alSRJPWTDWO0c2vGFpjsQ==
X-Gm-Gg: AR+sD105s+GJA7FDvDgoSuhHVYMvnhd6S4EPKBhGaENzunXlWqQcsZ4NQGOp+6UNEpA
 uj3Lz75qBsRhJoC6YT3eZy3g/OoKTnrHWL8SIPvkjUpDoxMs2C9bqdhcM6X8E2/foRyJ8ifbwst
 MaIKmJqkqm/hKKPJsAW8vjvUr44iOUVbCr/MboMJTYXgI5/HEVNOki433BNgZOTutKutiAxabCn
 mwKGHOmg8lwjRUg3d1zLqAhqpd8h97GVl8yxYSWaplQSUPQ/a7OHAv2adS79aHDw71jZPbAvt+j
 6zFm0fRx20sKEdPn+KHiWWU1ZOI3m9ZlUZH0qBZqpDwxlF+bX/pOb/fndsfNA8RLZUWG
X-Received: by 2002:a05:6214:3912:b0:907:5516:3d61 with SMTP id
 6a1803df08f44-90c80e00654mr311674186d6.21.1787599566556; 
 Mon, 24 Aug 2026 12:26:06 -0700 (PDT)
X-Received: by 2002:a05:6214:3912:b0:907:5516:3d61 with SMTP id
 6a1803df08f44-90c80e00654mr311667936d6.21.1787599561277; 
 Mon, 24 Aug 2026 12:26:01 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c93a7fe90sm69236186d6.43.2026.08.24.12.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:26:00 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:25:57 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 0/9] Remove 32bit support on system/user emulations
Message-ID: <aoyaxQhwn1OjuynW@x1.local>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Aug 18, 2026 at 01:20:03PM -0400, Peter Xu wrote:
> v1: https://lore.kernel.org/r/20260814134035.2733355-1-peterx@redhat.com
> 
> In v2, I touched up the original patch per suggested.  Then I added some
> more patches, almost quickly looking at references of HOST_LONG_BITS and
> clean up those I feel confident about over 32bits.  I still left some there
> (dev-properties, qht, etc.) which smells like tools may still use them.
> 
> Please have a look, thanks.
> 
> Peter Xu (9):
>   system: Define ram_addr_t to be always uint64_t
>   hw/vexpress.c: Remove forced cast to u64
>   arm/mps: Remove 32bit define for MPS3_DDR_SIZE
>   xen-mapcache: Remove 32bit support
>   bsd-user: Remove 32bit host support in thunk_convert|print()
>   linux-user: Remove 32bit host support in thunk_convert|print()
>   arm/aspeed: Drop ASPEED_RAM_SIZE
>   hw/arm/raspi4b: Drop board_rev for 32bit hosts
>   machine: Remove 32bit limitation on ram size

queued.

-- 
Peter Xu


