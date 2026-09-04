Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69BDC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Vo9-0005UZ-2Q; Fri, 04 Sep 2026 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Vo7-0005UO-GW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Vo5-0007N8-So
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788535580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3JFa2v60Jmk3fffVpZ0Ca7xxrh4ECr2iAWlS3jlX2U=;
 b=MjapyH63pCJ00nlGCys+80QMaQ8JFlHEZwWY8BMa2+DEGLv2NIvqSdn9AIhdtMK6Q9idDl
 oBTTGnh5Du7f/DGcqOGlUlFZURtbAYGYT7B1ui2oxED6UYr/5omiOpYlioQq38mYhojmR4
 ZYXFygeR+rQdKOfMUneU9wYAO5Gh35k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-oOg0TQW1MvaJv1jKcyP2rA-1; Fri, 04 Sep 2026 11:26:18 -0400
X-MC-Unique: oOg0TQW1MvaJv1jKcyP2rA-1
X-Mimecast-MFC-AGG-ID: oOg0TQW1MvaJv1jKcyP2rA_1788535578
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso26238786d6.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788535578; x=1789140378; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v3JFa2v60Jmk3fffVpZ0Ca7xxrh4ECr2iAWlS3jlX2U=;
 b=KNPuYWihKHKR2mmjs3P8/RNXStYJ+PtmPiBI6Mib3nXeTzVgUpo4crUaYIgB2L1SbG
 QP9Zm+51vFZ2kVF0DcHTv5R5zzbhZly32X9+SF52Qg31Z35Xd5sWVOeeFAGrCKMQQWM5
 K8/4UmIw9jqLHZmZsz5F/z93YUNxN+jFRwTM75zC9X/DUcyrdj2GYXnLqgEx5MX7jKPL
 0oDsZBlr7iuU5eLM5oy0blqwm2NhFvHw57sEc3Q7jQRiwfnPz1q2BX29iFgIvJVIb/WO
 CAuCa7DW3fDOBh5Go9aQHT0KD/NiiFO8lbT9EncOls4Haq90NmfpXLCUbF/JtT9Cot9L
 sL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788535578; x=1789140378;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v3JFa2v60Jmk3fffVpZ0Ca7xxrh4ECr2iAWlS3jlX2U=;
 b=tGBTISVo6DP5dPDRGObU5ESZRttXxHjZNhiJ/Vkf4o9UHbB4SAgGc3rGgVqn71xMi7
 Vq/YInItwlWIqZAPk6Hg4uHh/POIyFdjNxDpa5MnaDlXvF/1hOsqrpOHRFB4a/V0S04f
 TU9psgbwCCAEgRrGmJlwNhTksTnmAmF2IdoSiCunfDxKjAh8U3i1AuGRVhapeaKdZO3h
 0L897oY9PvLnnd8BTeK0T9cZQ0rnzoDyq/QdDBzlT6uiCLV5+YeIDAqRS5OcdueUKTAo
 lk38ASnGg8PF9vhV589Scddlr+vUVGM8iXB9P5on0BRn5JMyK8clJUOogwK8UrafYB9O
 BN6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+HR3W2YZ0p5FQ4pzrjAsompU3wEShcJteixs5l4Cz31gkJWUa2Rp8MRHCkR+nwVHCkJWMXDUVZwLK@nongnu.org
X-Gm-Message-State: AFuF++nTgo2mYWo5sDyK4J4PRRzyY3v68v8Dl5Fn7taDbRY/ppPAiBNU
 OGtonq4k2YSBj+VC4zDrd1fgVMlmYI5bnH0FRFif1Rtr6lNpwqP8q2Mi8KoyFoxhDQgfO+nm05F
 N30dM6IwiPrE2lekp5VjZEXRjBY7V2tLGyCrfOqsktS+j0gQoYxFBirPh
X-Gm-Gg: AYBFou0lv2IhH6z8P/jxO8Gzo2LT1mULHk2Em8a/hMlZB3osOkh5UUK3huVKiQXSJuH
 /YcvBjaDEaYBBxDnm8++ZXMhIK65pev3QSSztWRwPqEiPVy61KWPilgEC8CgwZWD9O7AEnDqCrs
 Xnf5Tqhii/SZapPURejlOq9jMWulA1WnEl7q4wmpUIv9hFoa8eft1pp54ifd3FdDmcQG59ORkb3
 GCm3oVxbkOfUIacKZ9hyYhla64WL0hZ7cL8rU6rSITz522pMs4ZVSLP0hh4vylUzc35skUy9q83
 RySN45496b/lvOqU3XZFCrW47L5XFEd3rdDcM+WbPWNT4TDgNQMsAkCuZc8eVYiDYCBw
X-Received: by 2002:a05:620a:4d3:b0:939:6de4:3e10 with SMTP id
 af79cd13be357-939804268cfmr486881485a.29.1788535578100; 
 Fri, 04 Sep 2026 08:26:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4d3:b0:939:6de4:3e10 with SMTP id
 af79cd13be357-939804268cfmr486876985a.29.1788535577519; 
 Fri, 04 Sep 2026 08:26:17 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93988e9f80dsm101792285a.24.2026.09.04.08.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 08:26:16 -0700 (PDT)
Date: Fri, 4 Sep 2026 11:26:05 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/18] migration: Use keyval input visitor in HMP set
 command
Message-ID: <aprjDbm4K687XYqN@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-12-farosas@suse.de>
 <apnOB4BfUEeOECU9@x1.local> <apnXdzc3q79KtDhv@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apnXdzc3q79KtDhv@gallifrey>
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

On Thu, Sep 03, 2026 at 08:24:23PM +0000, Dr. David Alan Gilbert wrote:
> Someone will have a test script somewhere that might depend on it
> (I know I did when I was debugging migration - and I never remembered what
> was MB or byte!)

Me too! :)

-- 
Peter Xu


