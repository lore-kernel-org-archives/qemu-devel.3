Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA2CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Rh-0008Qm-Nz; Tue, 11 Mar 2025 11:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts1RO-0008Kc-MX
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts1RK-0007Dc-6d
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741706561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=akSwLdqO76b7++SYkCCk7i+0Ko2BEOVycoPEURXGwMQ=;
 b=ZWAX4zdvWCeFBgzRbCYVdTx2UifaNQxAZ3Vgdd5hXYpaYjKsI26A7MV5OnzOMX0GQCsEGb
 h5KJ3yXmKNydFRUF/tQRkYLEXOErb9vHoeCCig+aGngEhPxVOuDgyYUfbnmVwn7tgH7K+W
 MajHBSzQsT5IjolA+H+Q5OR14flLToY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-lHwq0vZnM6K3CBFYsVvWrA-1; Tue, 11 Mar 2025 11:22:38 -0400
X-MC-Unique: lHwq0vZnM6K3CBFYsVvWrA-1
X-Mimecast-MFC-AGG-ID: lHwq0vZnM6K3CBFYsVvWrA_1741706558
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-476aa099fb3so4693031cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706558; x=1742311358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akSwLdqO76b7++SYkCCk7i+0Ko2BEOVycoPEURXGwMQ=;
 b=YTrNpwLbKGju3YAwda0KOTvWrn/iKy89WpVdD98g4hdsFjtlZ1ElIy662OWOP0F7c1
 zk7+f8MagcPpYCe5SBqD9Y1F/BWFWegC+HyYxuZ/3+69WoSFS6WIeS0EmE1O9S5znWKh
 /aBA+bUsPpGlJvsWHHAaXmmoUfeTwo6I/f1VuUOzxoh5FnRTt1LNRbmsRlyvw3t6WSZC
 yiGYGM/5xCb1hu8zjQTUiu2bk1M1oEFFtfUn4JiTHbgiCsctippQStIzQz+wDbEPIxHW
 Ue5wj2nUd2E010K3chWSiA9+kWQuOjIoknET7ZiJhadNLKBENiHtP1a3Ww7Zeicv+URH
 Upbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUWh/arBvooo9xOkFfmkCO6bz+gpiwKE6zsN099ljlQo3AmFl/aWww3QoAJOzJVFFqUpsLdAhAstud@nongnu.org
X-Gm-Message-State: AOJu0Yw8+PxpJeIDYvORfe75+D37iUCP6YhQOYYRfsURidScMaDYEIr9
 AzuIHzC6UZgGAqQBaaOlH/bzmlY1eqIwQMgneJ4iryByzIbViJ+6id4K7hnDCIoVJv2ESf3/ywh
 fOn0QnFwtgyhuRRGni9Mq8G+pTseaM6A+T7GSApnrSEByyK3TIoI3
X-Gm-Gg: ASbGncuUY2b7i3mNo2mZnvZcRx2YSbrDqNAOEkM3C3Kyy6kiKrHoxELPVMsO6o8uHdX
 4OfZazVujegWbrjWU3ZZsnj7kixh8wUqYyOGr3ZYri7xyaLb2J0MhshFF5jMvKshwwbX2xKWYa1
 dZEZKGTsRY0blVULlQ7Esafp8p3ajJ+5i663x2dXnZNheptNtQS/AHaQjbvHBVDCbNUxoKhPu++
 gHE6MbhwWu+/Icmf896XClVSNIGhgrVH1M6dIq5mp+Z4fevCUJFgqduYy9BdQ3j/6CnavKShzVx
 ZoO1RCU=
X-Received: by 2002:a05:622a:144a:b0:476:9377:17aa with SMTP id
 d75a77b69052e-47693771933mr86799031cf.52.1741706558426; 
 Tue, 11 Mar 2025 08:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuKBhRyg1CRJqtytvERXbrPI1AKxm+G7f4neYRVK/udgVbcT2v0brOH/3LpXGuFDHXlXT7KA==
X-Received: by 2002:a05:622a:144a:b0:476:9377:17aa with SMTP id
 d75a77b69052e-47693771933mr86798721cf.52.1741706558168; 
 Tue, 11 Mar 2025 08:22:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4768fb6eaa2sm25881861cf.1.2025.03.11.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:22:37 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:22:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, leobras@redhat.com, farosas@suse.de
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z9BVOn7x8N_f_qud@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local>
 <a384ffc3-34c5-441e-9fdc-b82cf4238b22@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a384ffc3-34c5-441e-9fdc-b82cf4238b22@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 04:15:38AM +0530, Manish wrote:
> Thanks Peter, Daniel
> 
> Are there any code pointers where something similar is done? I can follow
> that.

Sorry to make you feel like we can simplify the code, it's my fault.  Dan
has a point that at least for now it's part of ABI, so we must need to
maintain the stats.

Then if we must do that, we don't need to consider deprecation in your
patch.  It'll be simpler for you.

Thanks,

-- 
Peter Xu


