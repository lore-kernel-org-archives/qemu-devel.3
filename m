Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B801CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUo0T-0002EZ-TS; Wed, 03 Jun 2026 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUo0S-0002E3-D1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUo0Q-0002Tl-RJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780502385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oG8hHrEtqUDuQR7JXO6q9EAanXp+RTIcWxlxAVIGXo=;
 b=KJUKhVPmaEPvKQ0NDx6AGeFKrxCyAoMKFg+D+4ZNhm34HrOArV/8DlB5qCl7QN/RacAZCI
 9ZXw9VOy7D1vUOL6853Myhq0AVkxu8K46JyiL5sapY+QUjaOW9AfN6tYnBpMMHtKbCKbSX
 lYW0oqEmhDMwSqhodZasnsaPwZvrsx8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-8Wm8lpu7PQGC_-jW6NE9iQ-1; Wed, 03 Jun 2026 11:59:41 -0400
X-MC-Unique: 8Wm8lpu7PQGC_-jW6NE9iQ-1
X-Mimecast-MFC-AGG-ID: 8Wm8lpu7PQGC_-jW6NE9iQ_1780502381
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cce4f4634fso107859876d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780502381; x=1781107181; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/oG8hHrEtqUDuQR7JXO6q9EAanXp+RTIcWxlxAVIGXo=;
 b=VYdWByvbYYTLc8VBmsmz7VXQ3I8M9F7GorqQQ7fbpU257ZUfB5Qb4m0xTEnxbG23rq
 KPbgctgOkpsT4aLqyVEyxN++zwlkZ8pNrfogHtE7uB5LqpQ5gCcCns5d797+eQ+lILIS
 VmNSIbnz/iuoDq9+rnWLUutDwQmu7yOY2spAetxNmbUCFLGlxwc2z7cYLD36CQejFSva
 Wk23Zzb0UuZCAczDdA8HqkUk0f2zZaIFR/rEK2CxlmdT0elssqc3rC3+oDzkFy4sG2+t
 NXVnQDtLjDlescBf0RcQX3ohJNcxvglCtuJhgZmhIT9Jwe30S8TFy7RMLqCoWTjS7jXd
 rWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502381; x=1781107181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oG8hHrEtqUDuQR7JXO6q9EAanXp+RTIcWxlxAVIGXo=;
 b=NvbmBM2dZafzBk6QS/dTy7TV8EcCn4Ivz8FA6NGGXjBowDKRHsKKoroA4Wt5gOBpQf
 ct4g3drUki5YQVMaENPBoPdXHkwyc5IcDkcC/mPn05tD5KJRxeJjSfgF3GHUxEuMEQJf
 6Mul2ITMjznYU8c351uLNHSxgwx/bhegfQcOZVOKnGuUGply5lEqBJ4jt14x5pShyYaC
 9ZR2OylrSo6YlAPh+6KeHfsIgQ+C1JJcMfifGXi65NEf/LtFOnmch7vwEVJq5L6mEFEL
 GYQTf1re59RdH3NSMI8pqZEGIgmAr4C1hBtVDORyVoN3t7EDKuFvcbwq4v8EN4f4mtRS
 U6bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H2uGwfkHDi4RlXRtrm6Q2rGAxCBDBydQ1pCbHGUr17I6wZcP+xRF9dduxj68KkXaI/JApX1cpxSp4@nongnu.org
X-Gm-Message-State: AOJu0YyykKocFCc5GRKwqoO5+bVkVmVjeYFyESVdxEe+982vO6rDqMxQ
 VnF8iWegDrRwjVvtL7ll0m9hICd+1rg7r/rqhV9GuQXShVDvgz4OR+aMvuoO56L2504/9qR2ham
 faKQtoAsc+61Fcpfoa+hgxzrTkRh3yHFje8ugVDJafgTPonwvkIiv02tx
X-Gm-Gg: Acq92OEEMGZ8hdBPTXcmzacrLv86NRg8OW5Jb0nxz1gG3d7T4faXM/BYXWJ5ynoU5Sg
 37/6ySzgXjBZ79AuJts0E6G2SPbxI3xHjJVRZ2EfwWSIBTGFJ8AdEu7cfqvYi3qqveF4BvASmAr
 c6WOb0eQsJ7UA4MhvCh0cIfNCsMCS5sDOMIUQA1qUZhIOckBKjLcaUSKNb1p6dJjc1y2rCc0eGm
 dI8VtGsmr6Ohk4de6S3gaABrwdYzS2QxHCF0p8XT7MztJ7HcqPp7fyCeAzC7R3jSLz9bMnEUGxi
 pXi5jHac9HrSYpEyBxUMSdjqI4xA7jl7uLxs6H/TVv8kTEOxYItx1r6BpaY7DNdF7D6LOhbiQ/2
 My+f61y9JY49F5/PHH5FZaUnFxA==
X-Received: by 2002:a05:6214:328e:b0:8ce:aace:eaf7 with SMTP id
 6a1803df08f44-8cece15026cmr51808486d6.39.1780502380666; 
 Wed, 03 Jun 2026 08:59:40 -0700 (PDT)
X-Received: by 2002:a05:6214:328e:b0:8ce:aace:eaf7 with SMTP id
 6a1803df08f44-8cece15026cmr51808186d6.39.1780502380221; 
 Wed, 03 Jun 2026 08:59:40 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9dfc1sm23794066d6.4.2026.06.03.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:59:39 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:59:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiBPakzg8080IOfo@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <283f85de-92b0-4c62-94ed-631221b62c07@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <283f85de-92b0-4c62-94ed-631221b62c07@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 03, 2026 at 04:41:31PM +0100, Mark Cave-Ayland wrote:
> One of the reasons CPR requires a separate channel is because it needs to
> access the stream before the devices are created.

Yes.

> Is this part of the same problem in that the migration object needs to be
> created much earlier than it is currently? And could doing this
> potentially remove the need for a separate CPR channel?

The problem is the migration object can't yet be created too early, due to
the fact it needs to apply compat properties.  That's why this series used
another approach to have a temporary early MigrationParameters object to
keep things until migration object is initialized (during which the temp
object will be destroyed).

Thanks,

-- 
Peter Xu


