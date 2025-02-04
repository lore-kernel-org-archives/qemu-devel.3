Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CA3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPLV-0000RF-44; Tue, 04 Feb 2025 15:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfPLB-0000PE-H2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfPL8-0007Rc-Kp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738700170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ky672YTQmjWMGag8fy+m246n/AOyR1jpDryCCQwPAUo=;
 b=XOXn02IGGTjCpTzt2CeNk/PrLgAugM0f4UUsbP3xrfTRx0D4DnoxP6z3xcNC4QLboteBDL
 nElhUgPRdELEdrteS0zS5cd4JBeWqY3SuF/jfCn6IKEMUogviL9O/Z2J9HZJzxa0W01K4w
 Is6nXEPxyS82pFo4TFcbiKoPjFkyc/s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-cNy_O8aVPdanTPYegJKT1g-1; Tue, 04 Feb 2025 15:16:06 -0500
X-MC-Unique: cNy_O8aVPdanTPYegJKT1g-1
X-Mimecast-MFC-AGG-ID: cNy_O8aVPdanTPYegJKT1g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6dd43b16631so68277786d6.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738700166; x=1739304966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ky672YTQmjWMGag8fy+m246n/AOyR1jpDryCCQwPAUo=;
 b=e0GfpDaaD0gx7b0Cp/gFCSOzHugYUIrl3JFBCHUl6jhFU++07ibbDLow+g8GsB4R4h
 KeAxlzxruU7xBkuM3YlzZyWnnmE5Vj57JJObuy1egqZn5uklMlGMz5uwqb8ncf63VXlo
 jId5gYBP8Jmd4fb7BgZITunZd8YsnOnW97lT2I0RoRita5sxPbFUtrsg7jg+tyQy2ae3
 Igpe0jgGdI/pKKFmJs9eP+nyA+99RNjCPMo7kmkpu5PS/F2P1v6kP6KyaPaJdQ/FfVgC
 EMMMw0T/hAJyerrwY6R0vhkvh500ICtQe+vJk0jcubDLqXJOM2eTJNdQemSZdfvnsBye
 IoCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFLz3TYbF4W5LHL3GWRq9Jwyf7VGQISY+JbdG/S6sIVZvIMZQxVSZbwW0ibb0xDy4BeqbWjB2t0nIZ@nongnu.org
X-Gm-Message-State: AOJu0Yxf9IQwX+G8YTWzx8iLm3tZgKp/qz6FkC2w3n4Ok7AveAyK3mAY
 Yi4NsN8ke7YqYvptimu+tx+JM79XXKRUfRO3xT96V2SVhf2pS3goOWCIr8j6v0IHYKs1jrwR26H
 pDVEEGFWVSMdEdHFmbs3DvHFGPLf2KsFV9LFJv9qTS4beeVDgwc9g
X-Gm-Gg: ASbGncsAPXMEwbJZlHAZTMfC5+ia4Z4Y4gBXXf+Cj0t+SvjbAISK1Ew50mlAYN1CvPp
 lcz1bK10PN7cQ0d8ubNl43ziPT8cg2F7jRMTmXuQIaU82gXhtvFSMoMrpb8/G262D5v5+ZKh5lU
 S5GVDtTwE3J7A5jVXEg5g1Ykdk6WTeoKxNPKzZOnoSlvvEhOpmknIy0PvfX7dcN+WNUdTm100EU
 H7IBfi/qUydj7yFe8KErqUlTANn3wO6CeXARGbTHF5pXOrYSeQ35TMsRMvRE+JFaLZRAFNTC8za
 XuO68uuPgGtEqBI96eiOJ8JcgaAl093nlEMNNBSKPzVP/j/m
X-Received: by 2002:a05:6214:20c6:b0:6e1:6e74:7ad3 with SMTP id
 6a1803df08f44-6e42fc02175mr1754226d6.22.1738700166340; 
 Tue, 04 Feb 2025 12:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOlF+mI/vvTUe/iYN0gk7LNwIXaBahqPZM+/F5HxL9HHkmy4JCWyJcAFN+Od6Rxf0D90gNbQ==
X-Received: by 2002:a05:6214:20c6:b0:6e1:6e74:7ad3 with SMTP id
 6a1803df08f44-6e42fc02175mr1753906d6.22.1738700166053; 
 Tue, 04 Feb 2025 12:16:06 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819cf5sm65353956d6.49.2025.02.04.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 12:16:05 -0800 (PST)
Date: Tue, 4 Feb 2025 15:16:04 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 6/6] hostmem: Handle remapping of RAM
Message-ID: <Z6J1hFuAvpA78Ram@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-7-william.roche@oracle.com>
 <7a899f00-833e-4472-abc5-b2b9173eb133@redhat.com>
 <Z6JVQYDXI2h8Krph@x1.local>
 <a6f08213-e4a3-41af-9625-a88417a9d527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6f08213-e4a3-41af-9625-a88417a9d527@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 04, 2025 at 07:55:52PM +0100, David Hildenbrand wrote:
> Ah, and now I remember where these 3 patches originate from: virtio-mem
> handling.
> 
> For virtio-mem I want to register also a remap handler, for example, to
> perform the custom preallocation handling.
> 
> So there will be at least two instances getting notified (memory backend,
> virtio-mem), and the per-ramblock one would have only allowed to trigger one
> (at least with a simple callback as we have today for ->resize).

I see, we can put something into commit log with such on decisions, then
we'll remember.

Said that, this still sounds like a per-ramblock thing, so instead of one
hook function we can also have per-ramblock notifier lists.

But I agree the perf issue isn't some immediate concern, so I'll leave that
to you and William.  If so I think we should discuss that in the commit log
too, so we decide to not care about perf until necessary (or we just make
it per-ramblock..).

Thanks,

-- 
Peter Xu


