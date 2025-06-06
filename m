Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E89C61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcYe-0001R5-Np; Fri, 06 Jun 2025 15:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcYc-0001Qe-Ho
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcYa-0004Ks-Tc
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749237406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGEzqIrXkf+flxN4+wK4QfTw4dHKiWVNT8TEtVFMp28=;
 b=P5A0odMs7euLXZUgoeI5+O5yJyHijswZrCnifkJyY5WHd2qwAODgmp3LAO+d4fX+ovCJbz
 mNM9U1kbFy8hoMX5R8Ip0gxWzB9Q/lYvPtpyARPHNHVMSYG+jleWuQX8yKe16OOvuRZhFI
 Im2s7l6odcXzkrp1e+qixnUICOhOXFQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-C7cojYAPMRi0Rht8hbCvBA-1; Fri, 06 Jun 2025 15:16:45 -0400
X-MC-Unique: C7cojYAPMRi0Rht8hbCvBA-1
X-Mimecast-MFC-AGG-ID: C7cojYAPMRi0Rht8hbCvBA_1749237405
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a4369e7413so50302661cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749237404; x=1749842204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGEzqIrXkf+flxN4+wK4QfTw4dHKiWVNT8TEtVFMp28=;
 b=b9JwWiDNVkbO/4NpjdRMh3zXZpNI3mOc6wcuAbUJnINxcRt8bvlO6pfObnL9cW1gCL
 xoDFMwuF0Ik5SCIf9uT/DolVE0SeCqKbtzGelRTM/iF0OMQmLqGjVGRC4Q9LgxVpbIGe
 3H/RffXZhN/CoK+GD0sBa49R+eJSI+N0VcrGpc2n4Vjk/0lvha06x/V/ufukfpYQRqHP
 yRasRp/JMWC6F2lWsFd6L7qoeft4Ons5GNTLgxV4DQpEwy+CQp+Xwds9mHEExdabSeiH
 1ReBQ37ic/4w83rgsUNxbPZi6FxOGptu8z4a9szccQP/ojlfNMjGd3/GlfhkPjjkE9Mw
 ti+Q==
X-Gm-Message-State: AOJu0YxmVdxis6g0TlOSwLZU4F7sUXX/5EaNXcASIBGs3l8vor5Ihua8
 cWN/DwH2XrDHcpv1OsXZ0HHtWUwPTjNEZwlH5vyVbvyHSJRNopn2xdluPOL7C2j9keCQIilnfYN
 muC7y4yOoO87zu8h0AuWwPcJks9JRSUzIqyf9ZjgQ6iyomGoCMEfGjotn
X-Gm-Gg: ASbGnctMvApAhrVKtC8o1697vazR9BydUv4NKs4VjIS9kvEKzyJjFX8/q1Ln/MZAkVT
 8fza7T9zIzSRqHXULAmyZgus6g9tpZGLLbq0G7swCuHy3hTnwVOqM4T4+SwGCJGv5XqnksnNPjk
 ts2EHSaVOwH1OgG1QJFHG3UPezI1CowvgTzcoHAxdvAaV+36D0FIaGQTkFSp7mlZo486fTKA0Up
 E0TpCaisEAWx5sgWcZ4A4WDcYGIFoK7EdBp6WXR3kOEgx8+eUvHOiWj9dxZKMKiYsFQ/qdjsygW
 7ag=
X-Received: by 2002:ad4:5de6:0:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fb08f6e965mr73763436d6.22.1749237404666; 
 Fri, 06 Jun 2025 12:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM75dk8EezTw/9SyGV3jwqNyLeeVq/kdSAY1VO9NGKsqrGLalMrzvF7ku4RbR0CXMc7ueVfg==
X-Received: by 2002:ad4:5de6:0:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fb08f6e965mr73763136d6.22.1749237404327; 
 Fri, 06 Jun 2025 12:16:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cb59sm15488526d6.73.2025.06.06.12.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:16:43 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:16:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 18/21] qapi/migration: Deprecate capabilities commands
Message-ID: <aEM-mY8RRLQNyPFB@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Mon, Jun 02, 2025 at 10:38:07PM -0300, Fabiano Rosas wrote:
> The concept of capabilities is being merged into the concept of
> parameters. From now on, the commands that handle capabilities are
> deprecated in favor of the commands that handle parameters.
> 
> Affected commands:
> 
> - migrate-set-capabilities
> - query-migrate-capabilities
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


