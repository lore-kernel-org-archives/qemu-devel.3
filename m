Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A163CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4CX-0008O5-Me; Fri, 26 Jun 2026 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd4CW-0008Nx-Ba
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd4CU-0006dt-MW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782471261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHU0O0w8yC3os0Q/jY7kINjDWncQePbPodtNLqqyVRo=;
 b=DY6vxzzcECWXLXu39OB8D/XYGcQi3lz+daTtHCqwoon3ffQMaCwrJGF+WRxIxfMMTx8QpY
 S8Utko+p5Kw2dAGYQdjzQiJ7MqmyAO0W+Tj82jnemWMm5VMOIS0bZZO89ao+msdoUddGA4
 0Y242CdqPLjRCwHsO3BzlmLbOzSwhYk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-PvzCyvRENNSQFco4Hnvkwg-1; Fri, 26 Jun 2026 06:54:20 -0400
X-MC-Unique: PvzCyvRENNSQFco4Hnvkwg-1
X-Mimecast-MFC-AGG-ID: PvzCyvRENNSQFco4Hnvkwg_1782471259
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92b2ccd7971so15200585a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782471259; x=1783076059; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aHU0O0w8yC3os0Q/jY7kINjDWncQePbPodtNLqqyVRo=;
 b=Xwy6Ku94z7fDjdkLpnkmpXY+D3bWFFPnR6B8q0KtXPWVBaHcZE2kU7nt0e6ht8s1ka
 s8whaSVv1xygKRatTuguyI3gzhoOESGElURdpBb4zG+ieF3oc/Y/GjduPOj92uXCIWjx
 WObIN89YIhJI+fyZhc239FgBAvVSjTzUZ/oDEzprywhGp7c0mwrF8i2RSzgqLuvn4vse
 s9Jff3vGUV0l5hrKq8vwhl9Aikc8QvtaGp/QKqlYriaHwDLF3Gt8tObuKXoXjI77GKQC
 2ki4iLdbPotIDj+JlnqEGiuxCR9z6X1UKQyMmEmwna0I+13hcT2V3+T9RqmC2ljPdyW2
 JdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782471259; x=1783076059;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aHU0O0w8yC3os0Q/jY7kINjDWncQePbPodtNLqqyVRo=;
 b=qyIJTVwGK0Ofg4v7PgXnWIjfBHv6mpg3eStQBNbUsq9Fv0+BqUm1+BK6x8wNrGvgXn
 zQn6j9sasZr9LAZbFfP/JhdxoHKyRa/DHs+H41xhx4aarZGqi6TKFqg5PhsqncWkjD36
 iYyGjZcbJ2LBa4J/Me4VAzI+G4hPDXAWSFYjX+RCusNk5sFX49/n3pfkahtBSvWEV/1L
 yoAKSQmlWKBxWq9jOVoG8B56ws9soghP5NMPTSKLB/DhYhIiJ4Sixq+WPlMFX0+EX24b
 aqcQjZWVjpte63fCY0wITYUYEE3/mbICx8/Tij7UhOxEOu/IGr9vWwqjWJ88tf/zz3dl
 X71w==
X-Gm-Message-State: AOJu0Yz46CYXC7A9Hnl1QLsPeVryRykwZaoCLPJyXjW0rXAS4IiIh1wP
 Fu+UKwcyR1AGKlDn5Xi9+c1XssN3m50ViUzFr+86voBzkhHZ4Ro6QNZVj7tF0jExaCvr9dlWP/q
 Mj7HQxhY2GtJggcGAPePKAkZSUmBdLI8YUXDrT/vybu1hCfVDle4pLCdzfOoeWGEr8hTAaj0MO+
 RzlUwxYuFwSQRc1ZzZ+0sUcGdLLjUbNAxp1ptxtytt
X-Gm-Gg: AfdE7cm9eWaH79qMOrAtbyaaJnb5U9Lt0xzbtJ2skyZ2G9iaDTPobnlWrrDCOV/PnxG
 v0h47bjCB+F1Y44Ds3j91OJqiloreWG9D/NbExQL12OMlewc41Ayu/GyBOKg37ctId2IrhoQBR+
 1EgZNZOCqrq/IptimuKxI+9+zrWWvfzV7VDBTm2hYMzDVtKfLt/aRgX6/cZblaVi3BVDEihix66
 j3Lk5VFHkXDuXkU52RU42b8INuR5DtCMLQr6+qdTRKu5D2vZRTLjCUaxbW2DAhdk55H7FeQ7CNE
 PrqkKAXcs5fqUp9HQDTdTmJMJa7dvkwCcm7QEXZooRYf9y0Fs8njsmQwyA4m3/BFrZcrj5JgO+K
 DGuHXA2QVj9mOr01EZCGnY+/H+2ue9KkhPavTbpovY1ABaXU=
X-Received: by 2002:a05:620a:270a:b0:915:8502:f7fe with SMTP id
 af79cd13be357-9293a8ac13dmr980523485a.15.1782471259190; 
 Fri, 26 Jun 2026 03:54:19 -0700 (PDT)
X-Received: by 2002:a05:620a:270a:b0:915:8502:f7fe with SMTP id
 af79cd13be357-9293a8ac13dmr980518885a.15.1782471258595; 
 Fri, 26 Jun 2026 03:54:18 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92600a87303sm1131918685a.42.2026.06.26.03.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:54:17 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:54:13 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v2] igvm: Report error on missing parameter area in
 directive handlers
Message-ID: <aj5PQHUjbPPIaX8J@leonardi-redhat>
References: <20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 18, 2026 at 10:44:02AM +0200, Luigi Leonardi wrote:
>Parameter areas are how an IGVM file tells QEMU to allocate buffers
>for runtime information the guest needs — VP count, memory map,
>MADT and so on. Usage directives reference a parameter area by index
>to tell QEMU where to write each piece of data. If the index doesn't
>match any declared parameter area, the data has nowhere to go and
>should be treated as an error.
>
>The directive handlers that look up a parameter area all return 0
>(success) when `qigvm_find_param_entry()` can't find it. Therefore,
>the load succeeds but the guest never gets the expected parameters.
>
>Note that the IGVM library already validates parameter area indices
>when the file is loaded, so this path should only be reachable with
>a malformed file that bypassed library validation. This is defensive
>programming against that case.
>
>Report the error with error_setg() and return -1 instead.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---

This patch has been included in [1] to avoid conflicts.

Thanks,
Luigi

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg1201200.html


