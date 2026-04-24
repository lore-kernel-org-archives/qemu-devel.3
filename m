Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E066CFED3CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGH5o-0008Tq-2g; Fri, 24 Apr 2026 10:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGH5T-0008Qe-S4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGH5R-00056x-Vm
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777039252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwumuizkFfW4BtGEByu3LeybmWfMZHEtBBMWT7PFlpc=;
 b=BWpcLz4vqMvhRYKZ/qJq6Qj7yWv6LhVy3//FEEkz4+cLh+9z8W/Q3ZQuxDD444y2oHpxGx
 PFrXz/vLQnUf+p7p7X528hmjuZTUSEzvLhf5/sXt7jroiq+Rj+CSQsvT39XbLkLYLEcgFy
 x9RU3nAQO9yuPknXktsuIvmsnNko7F8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-MbOv17ztO9G-t_z0GLUIxw-1; Fri, 24 Apr 2026 10:00:49 -0400
X-MC-Unique: MbOv17ztO9G-t_z0GLUIxw-1
X-Mimecast-MFC-AGG-ID: MbOv17ztO9G-t_z0GLUIxw_1777039249
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-672c40f3873so16288241eaf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777039248; x=1777644048; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GwumuizkFfW4BtGEByu3LeybmWfMZHEtBBMWT7PFlpc=;
 b=Go/fCEd1qwCn7gaJqzAtuaG4FHAJiq/Y6MQVRJrSbPUO39lQvChBuBez6bWYnPZ+oP
 L2LL42nm0NmqvPXm3wwb22faKP8pU0IwOjPeUzCO7ahs09tmbnrno/vMd917u9SUCpZI
 e+H1A+Jx7kEdZWHIO31zQhCVj8y7Pn1kd/aMM6cLBROYQqW83qYRK2S4dsqJ3uktq8gn
 rZtbTHVAQvARlEIIJ8Yg9EgQrqfms0opsKX6xSqOX4IccFi3IP562C/YGNu8YoXAAK/f
 bWiK2ywY4v2oWl7S8Qs4GkFynjuW/j5M7dYPUu+ja6/SV8UoTqB0dduoyQ5UhzzhiHUR
 eYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039248; x=1777644048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwumuizkFfW4BtGEByu3LeybmWfMZHEtBBMWT7PFlpc=;
 b=p/Z96k6SoFfwXQoJPjZAG+TdlJcBdFFfvIbD0riF+U4ZnDaJcQEyxN9kV6ro9NM15v
 n++H+H4mo+5uI0M94g0OJbdhRcmJw7vDqjzlX1yXkUFSvaWUmb9fllyMFEYDquJtPM3C
 E/rj/1kjjPLNWzmCCe278FIAuirzKlx3WXFvsAxYccqk8rzEYZk18vDdKJRn7AF+Ojvy
 SwDbdF0zPkpu+p2TeTGp/s8xS/1Hnq/R2iJxv0dqNJCmBvqrcVHyvXQ5w4PRnU8chMqV
 e93QQi1k0KE2NqeITLXW4ws2jNnTOuIxFsMcw7GR4b6lubrIC/NcdOvCwzWZqTCm4gKG
 EvvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FikYYtfqPw9FcMkcmzd9TSflDC+V4qVLqucKF8kFYuZQjKvdBHpmQkFj5OCOIRW4sVMdUh8eZb2/8@nongnu.org
X-Gm-Message-State: AOJu0YyxHTYokqOSwT6V0Elq3lkVP24uPzPpk4TllUyTKlqTjfCZUDoO
 CwhsnuWHs7IHbbB5urEkq6//9GUqDWEoHNcG5uzpsjowUc9O+kagEj8wA4lGFr0u/fOeAFDeNUQ
 pSYr0aLA+v7vwSEjHm46g11s5uIfqBb6SuMWtEOymsZfPJht3tJxJN+He
X-Gm-Gg: AeBDieu6wqrSXiQa+omsMk3EOYDjgY7KhRzc8JNVlxr3lCOpxWEZGLUZsZSTZWBImBn
 vORijtDUDkyLPPQt25iVnLrpjfajnRU5A8l3j5j7G8Yp1kEpxqmSfI9C+apFm0iffqVj6GRlIx0
 2T3gOcTkIbRSCnBK5ol9Ymn0R5gGBW5WHox3VlDJ7ikeKZ5bo+L6/BzZVVjeV5qb/XgIxLcYDAu
 BrOZgtRDxQQEAA4PQCrFsQNq/ssUiNFZBBsoWh49Kutb44IWXAncR0WqqxfHUGzAt3IHgPLlaby
 QbTg5wUrCDroa3KnGOI0uTbZ4piFBgBMSOCqteutoy3v22vfJc4w7x0w/e2v54fBXXBIP6T6Xm2
 x+l6K46LGX/BWGojJlYqSvG09ZGoiXv1v5gsEGmuXhC7Q54s9XXllbNhplw==
X-Received: by 2002:a05:6820:188b:b0:694:9720:65e0 with SMTP id
 006d021491bc7-69497206ca5mr10322794eaf.39.1777039246816; 
 Fri, 24 Apr 2026 07:00:46 -0700 (PDT)
X-Received: by 2002:a05:6820:188b:b0:694:9720:65e0 with SMTP id
 006d021491bc7-69497206ca5mr10322757eaf.39.1777039246262; 
 Fri, 24 Apr 2026 07:00:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe98dcsm1998381285a.7.2026.04.24.07.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:00:45 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:00:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Pranav Tyagi <prtyagi@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Message-ID: <aet3izm2oNoPgdgO@x1.local>
References: <20260423094438.43556-1-prtyagi@redhat.com>
 <aetGyqrqEdz2dLnc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aetGyqrqEdz2dLnc@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 24, 2026 at 12:33:02PM +0200, Juraj Marcin wrote:
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

Thank you!  I queued it for 11.1.

-- 
Peter Xu


