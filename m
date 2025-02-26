Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DCC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJfj-00005T-MJ; Wed, 26 Feb 2025 10:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJfZ-0008P3-Id
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJfT-0003fi-NI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740584990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ckp7L1D4nywAQc+dG2mS39YinzcMIeOK2u3gwQ5QKLM=;
 b=XrjX/F4gWWJwOAAPedjlN7c6cFJFNxnLysPxgzOrVYDXF+dkeypBgScLviO1eOuPVqTrUa
 gEAwpP+JxgVvFx53hUolSn87jPh+42ucY3m5jelXDIzkSVt/tome47lY5e7LsvKjDrpqfY
 +ipnN4JqMAcwDQz3iHnKdQGg5dUwTVc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zXDe-dPMPyecoeFRnxqKTw-1; Wed, 26 Feb 2025 10:49:47 -0500
X-MC-Unique: zXDe-dPMPyecoeFRnxqKTw-1
X-Mimecast-MFC-AGG-ID: zXDe-dPMPyecoeFRnxqKTw_1740584987
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c0a3568f4eso709808085a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584987; x=1741189787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ckp7L1D4nywAQc+dG2mS39YinzcMIeOK2u3gwQ5QKLM=;
 b=X8B+X5Qka+Ea910dfI3Y0N8OFQtRJK8i1a4/biBtI8b1sRVpBb2ih8TIh6es4+/TEw
 MZkwQGNjFhbGfqNtPLCbFlQykOiPhzZGDn2pLgpnt5InEKCq8WO394T22j9Lt9Oo1j3B
 YKB9AdHtA+JTXCf7a0qpSXB6A++PO1G0Ut6vreRxxo+i4oOHW329MnQi5fV1B+V2PHR5
 yFfR+VMG0qViXWR5V4Rdxvo3Fk1LlIpAa/9akOkOeYMZg78iIedGRAIePvDy0J5nFB5e
 x0IZml8LmItrAqOZDeE3mz337MtiU29TVDxtZ7V54kxfzErgRC5SSKbWnAUEWFwHwSVC
 OKLA==
X-Gm-Message-State: AOJu0YzJ/L+xqbDULdSinbYw7uCc3og0GHIPQCUixV5/ONtn0BvQ/0cr
 QzaKjhvGKfZ6rY1fKRPMl0plBb2137WOjUg00AvmeoFxcSr1jq2t0ti11gWYN4Bs6hnEtt4DnvJ
 XvL9pS8TNgkIbHsc4nGFVZ7gIqQ+54v/b27HZGP5k2yz0bA1RKOmV
X-Gm-Gg: ASbGncvXFX05y6XYOLXD2DrxF/RZsDsE0ojHpPogUFzS6mvsMDDslYd7gC2d/cjx6WM
 k9UFChhlD7rv/70b+XOw5UsZxW0aBvECaZPRouSCnQvOXtJHHAK8AVej5Iurd0/F6fdBEsY+FuD
 DRk9zdir5SVdU2kZWoIBg8bBgGrJhZqLJIFum0KWfiOvH1OcJnISJjDU9GQT4BH0psCKWDFBS71
 FaUotuGPwbLQqDytsK2EJPHRljbWc7z++CuF26KR2qe6Za33ZY8oFnNQCxJWDizdwm1xQ==
X-Received: by 2002:a05:620a:c41:b0:7c0:b336:5728 with SMTP id
 af79cd13be357-7c247fe6c97mr433799985a.52.1740584987061; 
 Wed, 26 Feb 2025 07:49:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELXrG9eFkLCVNFwzGqCSEDKpsTf8J7KXjZGLHVTVJAPJtive8Cn9Y3e/cwneiAadyU3GvMJA==
X-Received: by 2002:a05:620a:c41:b0:7c0:b336:5728 with SMTP id
 af79cd13be357-7c247fe6c97mr433797885a.52.1740584986769; 
 Wed, 26 Feb 2025 07:49:46 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c23c2a325bsm258278585a.28.2025.02.26.07.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:49:46 -0800 (PST)
Date: Wed, 26 Feb 2025 10:49:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/6] migration/rdma: Remove redundant
 migration_in_postcopy checks
Message-ID: <Z784GLmJcS148f8o@x1.local>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-5-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226063043.732455-5-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 26, 2025 at 02:30:41PM +0800, Li Zhijian wrote:
> Since we have disabled RDMA + postcopy, it's safe to remove
> the migration_in_postcopy() that follows the migrate_rdma().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


