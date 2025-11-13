Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC27CD8C94
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZiO-0002OB-ON; Thu, 13 Nov 2025 10:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJZiN-0002Lz-02
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJZiK-0003uN-QG
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763049498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie1ldV6aoNoQdUX/v5WzJPW1M7ai64kVojsh+jvbI6c=;
 b=IU2XyyDJ6L+FiRWJnkn/4HJf/oyZxKO2onSCeIFOdelygGzHDQ5I61rk7RxxnRphFdY6sp
 XjnwIQcbP2FcMxUtwbaQmKOBLef9mehJAQBvTdzlfqAPL0wddvw+P9XfOXC5GtBjb6V1jY
 V5PGnblhMu8iRD7y0tTvh5Pykfhkfbc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--L9mG6diPridHMrMA8bnNQ-1; Thu, 13 Nov 2025 10:58:16 -0500
X-MC-Unique: -L9mG6diPridHMrMA8bnNQ-1
X-Mimecast-MFC-AGG-ID: -L9mG6diPridHMrMA8bnNQ_1763049496
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a5b03118f4so624619385a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763049496; x=1763654296; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ie1ldV6aoNoQdUX/v5WzJPW1M7ai64kVojsh+jvbI6c=;
 b=VnJTKiTFEUFtuqxRcyNC0JGE2w6ELNFh6nSzjwMvp87VGuTwBmT3KfvuEVHc8U6Kdo
 u8W1KSiRgAKhxIaITEolVSDJb7FPh3fQONCYT9YJVVuhAaMYIQ5s139O18HfS+6wHoqA
 0AVR6SRZYKnDg73/u1XWiku0iXCxudykOYazicRDoxXcu7Znv5Ckm8KsRX23lifHUL/W
 dp0U6uzeKXGLPU55AmsRw+VNi7JA3uQ6Jk90F6cftQMtQOVCFZ18iyYxBFk3iOlifrGE
 Y7ob6uNuRPdIyTHab7CXly6n6dvTfeeb/vte/bTPna4o4xcfGWUylnTWMpKATkNF1ayJ
 4dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763049496; x=1763654296;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ie1ldV6aoNoQdUX/v5WzJPW1M7ai64kVojsh+jvbI6c=;
 b=vxUptVeki//Q6eNxBwOhBcjb97BwqySmXuGwt9giF/y4nZYEcVsovQdMeWIpmcvLM8
 J1TvOjXo/04xE78mb9jSe/3TGTLkuQuZzU+otWxdBeawK0Eia8XI8lcsry/CCE1seybA
 OfBZKb0cufOg1O+jLVrjypov/uV4qYJ219UwBkWKJ7Yuve8nAxRw6tgC5scFTjoIttPC
 L/+e2IPC4PrRy17OVWg06IOkQfPTk/2Diqe6oRzw0Tgfww3XM3VFp72YmzleAs+I0/9o
 UwRpF1aVyMeaKX1GWDE0qH94dS1FiSWTeer3uheKZzij15SkkDC/B+AlQEUlwDinqgEp
 Q86A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8tIA/+Z5rpvfDT9iflu1bgZccKslJkkEd2jjT3vrdKeLQksO9BCvLW9jphpjuN55wvK8MbCCm4GKO@nongnu.org
X-Gm-Message-State: AOJu0Yy7DsK9EemPMhaxYzMCg1MV5dxXaAbKndZpJlPhZMS0wRQs8oBE
 Tw6xq/4XWnKDhhZOGo2wjMJkEFtgFp/pMWejxAlfOb4sfngQxvrHGXDZIwnQ0WmCn08xJE8e08m
 /Vcd6t+PcJcVF29GNSUZAvCBGcZDT5V1U8Ia9avb1X8YfnkCwzzFc5dJ2
X-Gm-Gg: ASbGnct9c05z8/SintCd5CK/PG2PUx1qveniRaExZPNWpnERNPTVv/1K2eCtXJgGarb
 ygjRtoFAIPzmYjbC600qZdUmrDdVbFYvQY+9yOfCxD80m/vX0LMrorQgTFVW5okrR8cbJAwgcdg
 EAejcg2JUJuyTkYvQq8SdxNcaPstAwkoaXCSjXtqDEJr3T7n+Os0rD6TYks5jCtKyWtRMNU+cr/
 rr6q7/TZw7BVgOM9S3oqv3LAWsQBguawY/ka5a5tttneWjywTnFYSSaytDsZrw9mxNTOLmUuaFz
 XmtdXrJ0pGTXprBLIqxoICQAxVuDdJTaePiK7JPFnh4KovLxSaILi3WTW6Igmoz20sI=
X-Received: by 2002:ac8:7d15:0:b0:4ec:f152:9f4e with SMTP id
 d75a77b69052e-4edf2185213mr998151cf.40.1763049495813; 
 Thu, 13 Nov 2025 07:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6LswHLaLbdWAEfRWqegIoPorIALGCUQrh7ipvZqHCMtIlNC7BGYAswPAu0dBOA8hTEVdC6g==
X-Received: by 2002:ac8:7d15:0:b0:4ec:f152:9f4e with SMTP id
 d75a77b69052e-4edf2185213mr997631cf.40.1763049495270; 
 Thu, 13 Nov 2025 07:58:15 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede8848af5sm13961971cf.30.2025.11.13.07.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:58:14 -0800 (PST)
Date: Thu, 13 Nov 2025 10:58:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com,
 thuth@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRYADVaYZ-IprJwt@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <aRUCXvHkpfZgZCR0@x1.local> <aRWcimmBN23VzH55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRWcimmBN23VzH55@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 13, 2025 at 08:53:30AM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 12, 2025 at 04:55:42PM -0500, Peter Xu wrote:
> > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > We used to clear features silently in virtio_net_get_features() even
> > > if it is required. This complicates the live migration compatibility
> > > as the management layer may think the feature is enabled but in fact
> > > not.
> > > 
> > > Let's add a strict feature check to make sure if there's a mismatch
> > > between the required feature and peer, fail the get_features()
> > > immediately instead of waiting until the migration to fail. This
> > > offload the migration compatibility completely to the management
> > > layer.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > Jason, thanks for help looking into the problem!
> > 
> > Am I right that after this patch applied, whenever a new QEMU boots with
> > the new machine types (e.g. having USO* by default ON), will fail to boot
> > on an old kernel that doesn't support USO*, but ask the users to turn off
> > USO* features explicitly in the virtio-net devices?
> 
> What kernel version are we talking about where there will be
> incompatibility ?  Is it old enough that it pre-dates our
> platform support matrix requirements ?  Ubuntu 22.04 and
> RHEL-9 are currently our targets with the oldest kernels
> that we need to retain compatibility with as the bare min.
> I would expect machine types to work on these old platforms
> without users to having to manually disable default set
> features.

Jason's proposal should have kept the behavior for old machine types so the
strict checks are bypassed, so at least existing running VMs with old
machine types should not be affected on booting.

New machine types may suffer from this indeed, that when running on old
kernels it may needs some tweak on cmdlines.

There's another alternative, which we can introduce an option to allow QEMU
boot but forbidding migration (or at least show a warning to user that
migration may not work properly).  Then everything can be auto-probed like
before, because migration ABI is not necessary.

Personally, I think Jason's proposal is a good trade-off we can consider,
if we think migration should by default supported on any QEMUs that would
boot up properly.

Thanks,

-- 
Peter Xu


