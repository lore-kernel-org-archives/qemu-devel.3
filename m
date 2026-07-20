Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A440C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlq9L-00068d-Ko; Mon, 20 Jul 2026 11:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlq9I-000689-TR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlq9H-0003RW-2Z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784562198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTMRPge6YJDDFfmCYOV8FU9Z+e1p4dv1Gki1bNkbxHU=;
 b=F5FD+Hwdz50pbyX5XVr8qzSJJXA4EUpDuNOz0DIrGfq+OstRBDM/aWbSlQwJUg8R/RlTli
 VMMdQYslVp6mHRNf62M9v45ERLaiUdSpVwk7pX6ym0obX5+W1PjIrl8zuJTbEGpXgeoGrQ
 LygEMbWItRqBwUoAu342aFm/foZ/ev0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-kAaE1XV3MPajqhqFmpYzUw-1; Mon, 20 Jul 2026 11:43:16 -0400
X-MC-Unique: kAaE1XV3MPajqhqFmpYzUw-1
X-Mimecast-MFC-AGG-ID: kAaE1XV3MPajqhqFmpYzUw_1784562196
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso83520696d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784562196; x=1785166996; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YTMRPge6YJDDFfmCYOV8FU9Z+e1p4dv1Gki1bNkbxHU=;
 b=R0o3AEr9DVjmB0TB7YPCWrRXogsnvB4Dd1dMj/PxL5ZQIXA5Izt6dM3xI7dDmhsMhR
 663jCbv2cjo+15kBMgFCR0uzJCWASn1OzeM/B6tFR6byleaXGH4M+h+9GsG0wMHNmvi2
 oU4zOD0JW8A/re2ycu2D7DtMrm3++cWj2c20wzTdDQKo7i92LA6EUc51uFO4JbbEPM3Y
 Gd6/14DVAl6+otEXFxi2woqMK6ZowiXAp/exvUgEJqNBDyYgMhEe7DcyqeCLdri5ED2T
 ps4jKlnI8WDdte0/I9HkTQ4tufDQnJiE/KFEFLYDQbsTRQpXabWQqZpYn86rmk2nL3fe
 8WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562196; x=1785166996;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YTMRPge6YJDDFfmCYOV8FU9Z+e1p4dv1Gki1bNkbxHU=;
 b=s7hh7LDnJnyw6ZP1o6kKasIs8X8mQUDPxHL4GGV8mPEz/g40JNMrRdTcYLKmbvGmK4
 ZNMJqpAsbuuh2Oxijotpbq9CdIxrD3IGwm/LrVjCsQdkMU7jlvNKuHnXEbmGvOLQ7yNP
 kOv6A+U45Pz/Vl2CdVOKQjqZtySadPeeAhp+qeNYRFs46W3aiOBow/qlVbdItPYheUyq
 Zaoan+y6V+FnsPGHYP8SOX5n6JuX55coshIdTNDWKqTu1Ioeosx1odE0SfPv2DDPwCjF
 ZkDan03KlO1g6YrE/bEWXd56/fE4zdapKNxMtZJnJ1KNGinSvFXGMerWkmyf3oBuIgaZ
 s2fA==
X-Gm-Message-State: AOJu0YziJ9TyJYBXFbTGHAVoIdKfHCi+P+PUIS1nL3FUofwTlrod1IF8
 OkCKRR17jH8g0RRSsYwKASWC9pbAeKYT6N6lPvsI01o2wwnyfX9WJV1KJls93/AszRvwXqV2Gk2
 Y9EdgNcs3RENOs9v5ISXo6eqUrzc+9Ky7+8GKL5L3zvyGRy7cIeFl4TiJ
X-Gm-Gg: AfdE7clDJib8pkaUGkDzroh/RKGa+j3xCS0MWxkhFY2MIPJ/lkP5scTcrNa5XsXHCrs
 Omyy6cFEQQiSldGHzUN3pBdBjDgPgshjFlI4MNQFLGXFgGBya2XQELuMz52ZV5HqZMuLdjxsmYW
 +DOnwSHkHeaoA/lJrBblEYQNEYHaMdE5ECXu1f56KEqvP+je1k2FA+k4+UivEVD1IOaDdTiLOAg
 qtU5aey+tW6tJphzj8REWvrakRKwMvSViYBavQel3bjQ/RufXENJ3Cem+zOBTy1kzlnyG3fdiuD
 x7aKJ9Gv+ujFleAx5kb0cEYD+ZXy7icYI2lsT4uyrb3I189pUqA0KIxjsXC5tqce6iBY
X-Received: by 2002:ac8:570f:0:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-5213e48ba34mr122277581cf.43.1784562196099; 
 Mon, 20 Jul 2026 08:43:16 -0700 (PDT)
X-Received: by 2002:ac8:570f:0:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-5213e48ba34mr122277151cf.43.1784562195621; 
 Mon, 20 Jul 2026 08:43:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214d095ed4sm74834241cf.10.2026.07.20.08.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:43:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:43:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 01/11] migration: Propagate error in postcopy setup
 functions
Message-ID: <al5CD1WT9D3Y4N7A@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-2-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:37PM +0530, Aadeshveer Singh wrote:
> Modernize error handling in postcopy_ram_incoming_setup() and
> postcopy_temp_pages_setup() by replacing error_reports and local error
> handling with standard Error propagation.
> 
> Replace use of strerror() on errno with error_setg_errno() for modular
> handling of errors and change return values to -1 on failure as no
> caller checks the actual return value.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


