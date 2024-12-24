Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 19:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQAty-0006xo-GI; Tue, 24 Dec 2024 14:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAtw-0006xa-KV
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAtt-0000cM-IP
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735069743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FEsSSOiuZPff6JTwaC7LRGZFNrjGLZxdj126GlsgIXs=;
 b=eNHJIgU//3lOq+ikMzjDhgp39tZdXL1RPhNxzX5XtCpMxPeXAby8rnpIVNbUMX+0xgD57C
 S9c71WhHDkuK0WLIY4hfXw9Kc17MF//3XX/bySFir7st5ROh+ZSjPxGTqYfKI/RYr4DcN4
 XVMPrtErrjsuaUrT4FzOmyK3L7KvLeM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-YaNlhEOJOzGcNXbJn4hixg-1; Tue, 24 Dec 2024 14:49:01 -0500
X-MC-Unique: YaNlhEOJOzGcNXbJn4hixg-1
X-Mimecast-MFC-AGG-ID: YaNlhEOJOzGcNXbJn4hixg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467a0a6c846so133328491cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 11:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735069741; x=1735674541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEsSSOiuZPff6JTwaC7LRGZFNrjGLZxdj126GlsgIXs=;
 b=T/92sm9L6O2nPG43f0o35GO+r/vnDYkDurqn8MThqb+Z5JJ6kDp4Ih1vJDJrE04w3v
 0/Z76ngMLL0o+sd60jitz2lXi2c/c8RDYqYaSSOIXVSgSep87VdPhGCuW5MSW/kjSbmc
 ofXKsmx0UL/rOGIrrLbXl0Xw/BEFOmkxIJKtKQoOGasInbZx4z54Q8VafWn8andzVL5X
 wxzPFenfuSZhr8kNUd5DuyWYt9/U1bgZy3zXZ8vQubTdbofFEOGZN9rxxdv5gIp8tjID
 tEgvALlVX32CaZ15Hsb3kMjhtb0BwaZQX3Nnhm+5RKskKd0hKPtrZGwfrhZ2YkvRjWqT
 eHsw==
X-Gm-Message-State: AOJu0Yzw/ENtgK3yJu8O6kAo/0Rti6oj6ng89sa7jRFXW6hXGmsaHybl
 TXj7b8cLubuHJxvrdkhCK6zyrXaiXkZ2tdkj4i8V1jce3E2c1VG/sjM5wdiloO/DWxirTy6luS8
 YlBthW/1syeRWSrEd9ms/Vz8XBP75X7YsoPy6Vf62Tbi5QQSxY+IX
X-Gm-Gg: ASbGnctLgvarZOyMCzozO8gdQez4X0w8NuVpT4BScKv4VvyAmWTWX2x5fM5A7T4z7s1
 Prl8tJ2HMNsrduOu4KSiVVKPZkdzqfI+2yjtoRWG7z5JLB9QrDN5JlBIsb7ejkKX7ecq1aZW0Me
 CBROn8VMmm+03ibIBNDYdvlne8nZ87CT86bsdbcfpyOmpsUwGx2KM6rtcC3MfUaGkJ6c5saPw35
 doY/siCsSPKQ163AALE6mc+G0Qb7t4bHfhPhR6MrsrPcg+10JnYbSsgCDuPucj8eQIzyJ++orIQ
 DKhPIZ75k+ShFW/TTQ==
X-Received: by 2002:a05:622a:15ca:b0:467:7208:8ee8 with SMTP id
 d75a77b69052e-46a4a8f1203mr247026111cf.31.1735069741039; 
 Tue, 24 Dec 2024 11:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHglA8GYYYt+Zm9+swycQvbXCNRqk5wgrUoTiFgRMYi2JyCOSv7yGH8+QZwKiHa/hgdGjlMDg==
X-Received: by 2002:a05:622a:15ca:b0:467:7208:8ee8 with SMTP id
 d75a77b69052e-46a4a8f1203mr247025981cf.31.1735069740795; 
 Tue, 24 Dec 2024 11:49:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480908sm492546185a.80.2024.12.24.11.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 11:49:00 -0800 (PST)
Date: Tue, 24 Dec 2024 14:48:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 20/23] tests/qtest: enhance migration channels
Message-ID: <Z2sQKt8dZKC7gAmV@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-21-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-21-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:17:05AM -0800, Steve Sistare wrote:
> Change the migrate_qmp and migrate_qmp_fail channels argument to a QObject
> type so the caller can manipulate the object before passing it to the
> helper.  Define migrate_str_to_channel to aid such manipulation.
> Add a channels argument to migrate_incoming_qmp.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


