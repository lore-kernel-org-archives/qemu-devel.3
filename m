Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B880CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 21:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulaV8-0002bd-8b; Mon, 11 Aug 2025 17:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulaV5-0002bH-9z
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulaUw-0004ri-JW
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754949359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=veMjrKxppGlqHtorN+ASU/1tMLq+i4N9/I5pQ7URsKo=;
 b=I5lDlhUFZuybQnrCNICoFRCb3W1LeSKMHP8yymV8Kzcvpzbcexg5iWkeTb+TokdwXwwsD7
 QMSArll4OUNlAmsmKXhHmjE6gEFSanaz3BU6uq8Ka7NVJmxABwF8ZiuEjkBhhGrwyyP2ch
 jOC8Ox/RSjBefrG0SFkONCbkhwngf78=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-EJhPgxXHPTS1Latxq-D1GQ-1; Mon, 11 Aug 2025 17:55:57 -0400
X-MC-Unique: EJhPgxXHPTS1Latxq-D1GQ-1
X-Mimecast-MFC-AGG-ID: EJhPgxXHPTS1Latxq-D1GQ_1754949357
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7073a5f61a6so90009736d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 14:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754949357; x=1755554157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veMjrKxppGlqHtorN+ASU/1tMLq+i4N9/I5pQ7URsKo=;
 b=rytRHP8Eziy+eu19fvONsYbjoJ1US47Ia6F3Ztr28brg5mtMJmMOt7YGK971TfPLko
 McAsmsGBG/V82UWRtlGkH61uO0wtZlETlmBoDtl02S2Mcm0/s7ncZM+MjivCzzzU1T1m
 k6QlnuTYsrvj5oy7HaE9GqPBMgilh1cIX4qNYbGdU7ehmRL/O9bsiOQBch42St8vJ+bW
 OVdhRq3T/QDQz8N+t5SUk0cVykGE1+GP6oWIlwigQpcNATfqYqePfJYnllvR998y+3il
 Eq8TYnHJwV+ChAKHR2UM9loO2UeKQ7/2JK/OR7hTd4S5Ag3D+3YOh3PIk8siq12g1CHB
 DwaA==
X-Gm-Message-State: AOJu0YwfpDdyiPTFQBcD596i+L+HMjm7I/7pGC+nlOn8cyqG0+8ykDwb
 i6uCv1wMdS4Mljv8887hCIcXRw5P9fCKxF4jLZSsvPS/hIIxTsW/uMc7T1S3lAq6Wu4Of9iFk6o
 LGsEIQ38pQUmZJclJus0OgoawxJ3rzAeOtveteaWgcM5OYKf9nwxzBf4Q
X-Gm-Gg: ASbGncvIiR9e6C1Z1KpdCua3IuJfOilJd4rAXgsbhVLvJRgznbG4kubqlolL4SNxsLv
 SK6rgeqs+yRavhucHd9CiMyi6tIpDi4G4HKftslBrJO8TQRfzZI2pL61xzQ1+gTYusLTJ6GZGy1
 5iEmV/CHrQAFLKvezLm+PPVvXZ2kOn9IC6Pq688uAHIettkGiu8E6nHZ+XTDmyFemyx4eweY/pd
 PS8LBRV/toou+bLzY4MtHQsD6mHn9RY4SpfIbqpturmV//yjTFzjTcEcv+sTdiHoJUF4/L3iugZ
 3rpCdldGy2D++VMAELWVSKhW4FcVXeI3ZvhT4otl2P+gV/G18+4KF/Za4h9w+rlnFrSfTMeExMB
 tnLMKOkajS6zHRJSddwJ7iw==
X-Received: by 2002:a05:6214:acc:b0:704:f952:18bb with SMTP id
 6a1803df08f44-7099a393a00mr182827436d6.46.1754949356939; 
 Mon, 11 Aug 2025 14:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlMdIS4twARrhtpefveW0w2Blgox3ELCKiQmINiqFyg+lBh+ccoBkaYghid5w4S38EzyPNyQ==
X-Received: by 2002:a05:6214:acc:b0:704:f952:18bb with SMTP id
 6a1803df08f44-7099a393a00mr182827246d6.46.1754949356458; 
 Mon, 11 Aug 2025 14:55:56 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca363fesm162246236d6.31.2025.08.11.14.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:55:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:55:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJpm4-JfmevsI7Ei@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> This effort was started to reduce the guest visible downtime by
> virtio-net/vhost-net/vhost-vDPA during live migration, especially
> vhost-vDPA.
> 
> The downtime contributed by vhost-vDPA, for example, is not from having to
> migrate a lot of state but rather expensive backend control-plane latency
> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
> dominates its downtime.
> 
> In other words, by migrating the state of virtio-net early (before the
> stop-and-copy phase), we can also start staging backend configurations,
> which is the main contributor of downtime when migrating a vhost-vDPA
> device.
> 
> I apologize if this series gives the impression that we're migrating a lot
> of data here. It's more along the lines of moving control-plane latency out
> of the stop-and-copy phase.

I see, thanks.

Please add these into the cover letter of the next post.  IMHO it's
extremely important information to explain the real goal of this work.  I
bet it is not expected for most people when reading the current cover
letter.

Then it could have nothing to do with iterative phase, am I right?

What are the data needed for the dest QEMU to start staging backend
configurations to the HWs underneath?  Does dest QEMU already have them in
the cmdlines?

Asking this because I want to know whether it can be done completely
without src QEMU at all, e.g. when dest QEMU starts.

If src QEMU's data is still needed, please also first consider providing
such facility using an "early VMSD" if it is ever possible: feel free to
refer to commit 3b95a71b22827d26178.

So the data to be transferred is still in VMSD form, aka, data are still
described by VMSD macros, instead of hard-coded streamline protocols using
e.g. qemufile APIs using save_setup()/load_setup().

When things are described in VMSDs, it get the most benefit from the live
migration framework, and it's much, much more flexible.  It's the most
suggested way for device to cooperate with live migration, savevmhandlers
are only the last resort because it's almost not in control of migration..

In short, please avoid using savevmhandlers as long as there can be any
other way to achieve similar results.

Thanks,

-- 
Peter Xu


