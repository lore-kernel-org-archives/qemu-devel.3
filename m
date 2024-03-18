Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0072C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBab-0000LI-AB; Mon, 18 Mar 2024 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1rmBaZ-0000Ka-Ss
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:55:35 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1rmBaP-0002QN-Gd
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:55:34 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512f3e75391so3221754e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762922; x=1711367722;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GW5y8fNL3N/3morbKABzGjIncGz4LjPASv+Wo+zVV4k=;
 b=SK7xhpUkXXWlw7XQWfKG/go6224CJ2tzwciz3JeJy1219FmkRk9ZNF2xBtWwzbNTsx
 s1pe0wWvUdqRJ2FsSYs6ASugCG9wZAiiFkm5efXqeBawFNlEXXW4hwe+0yHlHgGGMUvU
 xICQdPzCjYH7V32znzOCiGjFhG6kslG5ebzxLTZC0VkQSON45m0fBfBbiZ6FbaBTe6Gp
 BZVJSCpE+ZZvbivuCNcAdykJmavW9sJh3rbH62E09u6KodPWjwcUbZxo7z25QOcK9TWS
 BpT4mswOYeSKFqVfgZ4SaFTHr61KTn6jG759K9rqa4OA7RmGZtDDvZe8HZiv1st+TMpP
 gs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710762922; x=1711367722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GW5y8fNL3N/3morbKABzGjIncGz4LjPASv+Wo+zVV4k=;
 b=pwzcz7FIwJLPJtcXm0Od0X/lpcjznNrDS0iBGxtaTkFQyCUsInq0a3Lf2CicvwoITH
 eW5ZxpbuApZu1igeZkl/3Ivr9w7GxnHWW86nxiyYISpOFrmPMs8/Rh7o8suSrSM0NBZ/
 3CAOAkhXDh0xbPjLyKc6+mraHTt983a9utamuX+GYr1KopCznza7FgoPx2skyZQbBSc9
 y9FtEt250cXq+18Padp/fTKksaaMOXW0sNQz7UxOeUSjpKrlrLWRPLASWnjlmojE68fw
 F2jQBWajhRjnS51isL/MlvMw1SXTBRB+bSeF2zvWLXV8Y9Ft3g3b3qipfubTlB5XAnzF
 R8pg==
X-Gm-Message-State: AOJu0YzQlpYAPZogV3yZ6H01cgK6Xnl4LTmljAJ1cmtxlQqzgm7weIMU
 KScdjbGsBMIEtpw7Pi61AOKkDOlFMXlQOhm3JypbvmJyVOsFwAj24GJ6VFIWjUs=
X-Google-Smtp-Source: AGHT+IEWy1ryDBZIH4c3Gnuv/Dku7Y8iPOJCiJu/lUCAsOCAWpu41RhR1BO6xK2lg3Yazruu8hHzOg==
X-Received: by 2002:ac2:4ac6:0:b0:513:5af1:9d7b with SMTP id
 m6-20020ac24ac6000000b005135af19d7bmr7767772lfp.47.1710762921520; 
 Mon, 18 Mar 2024 04:55:21 -0700 (PDT)
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 ld8-20020a170906f94800b00a46754900a4sm4479799ejb.33.2024.03.18.04.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 04:55:20 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:55:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 leiyang@redhat.com, schalla@marvell.com, vattunuru@marvell.com,
 jerinj@marvell.com, dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Subject: Re: [PATCH v3 for 9.1 0/6] virtio, vhost: Add
 VIRTIO_F_NOTIFICATION_DATA support
Message-ID: <ZfgrpS0mxLW2LMVE@nanopsycho>
References: <20240315165557.26942-1-jonah.palmer@oracle.com>
 <ZfW-tO4zXeAWDgFg@nanopsycho>
 <89dea52f-b4cc-4a8b-986b-68d73df180fd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dea52f-b4cc-4a8b-986b-68d73df180fd@oracle.com>
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=jiri@resnulli.us; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mon, Mar 18, 2024 at 12:22:02PM CET, jonah.palmer@oracle.com wrote:
>
>
>On 3/16/24 11:45 AM, Jiri Pirko wrote:
>> Fri, Mar 15, 2024 at 05:55:51PM CET, jonah.palmer@oracle.com wrote:
>> > The goal of these patches are to add support to a variety of virtio and
>> > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
>> > feature indicates that a driver will pass extra data (instead of just a
>> > virtqueue's index) when notifying the corresponding device.
>> > 
>> > The data passed in by the driver when this feature is enabled varies in
>> > format depending on if the device is using a split or packed virtqueue
>> > layout:
>> > 
>> > Split VQ
>> >   - Upper 16 bits: shadow_avail_idx
>> >   - Lower 16 bits: virtqueue index
>> > 
>> > Packed VQ
>> >   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
>> >   - Lower 16 bits: virtqueue index
>> > 
>> > Also, due to the limitations of ioeventfd not being able to carry the
>> > extra provided by the driver, having both VIRTIO_F_NOTIFICATION_DATA
>> > feature and ioeventfd enabled is a functional mismatch. The user must
>> > explicitly disable ioeventfd for the device in the Qemu arguments when
>> > using this feature, else the device will fail to complete realization.
>> > 
>> > For example, a device must explicitly enable notification_data as well
>> > as disable ioeventfd:
>> > 
>> >     -device virtio-scsi-pci,...,ioeventfd=off,notification_data=on
>> > 
>> > A significant aspect of this effort has been to maintain compatibility
>> > across different backends. As such, the feature is offered by backend
>> > devices only when supported, with fallback mechanisms where backend
>> > support is absent.
>> > 
>> > v3: Validate VQ idx via. virtio_queue_get_num() (pci, mmio, ccw)
>> >     Rename virtio_queue_set_shadow_avail_data
>> >     Only pass in upper 16 bits of 32-bit extra data (was redundant)
>> >     Make notification compatibility check function static
>> >     Drop tags on patches 1/6, 3/6, and 4/6
>> > 
>> > v2: Don't disable ioeventfd by default, user must disable it
>> >     Drop tags on patch 2/6
>> > 
>> > Jonah Palmer (6):
>> >   virtio/virtio-pci: Handle extra notification data
>> >   virtio: Prevent creation of device using notification-data with ioeventfd
>> >   virtio-mmio: Handle extra notification data
>> >   virtio-ccw: Handle extra notification data
>> >   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
>> >   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
>> 
>> Jonah, do you have kernel patches to add this feature as well?
>> 
>> Thanks!
>
>Hi Jiri! I think there are already kernel patches for
>VIRTIO_F_NOTIFICATION_DATA, unless you're referring to something more
>specific that wasn't included in these patches:
>
>[1]: virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
>https://lore.kernel.org/lkml/20230324195029.2410503-1-viktor@daynix.com/
>
>[2]: virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature support
>https://lore.kernel.org/lkml/20230413081855.36643-3-alvaro.karsz@solid-run.com/

I missed this. Thx!

>
>Jonah

