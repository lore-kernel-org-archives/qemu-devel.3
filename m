Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F31C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ihO-0003G2-DG; Thu, 10 Sep 2026 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4ihM-0003Fg-Rb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4ihL-0004SU-Dh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789061790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PZ/XuKVqhA3EBO7HvKnXNkby/fV3O74iWiuA0/KHA4=;
 b=QEbZ2dlH2Fs31ZYsCxqDUw5zp8KCU6jhncODhua37Y0/aHAQMoHEYHb9mLr3ZZAFCR3aI1
 A6VPkeH5YDpnzGJsqSqB35mKO/wVv8UsOTP4lVlIDLx1y4TjYFLyWExuazgT4UyyNmAbZW
 BHqvl/pWgzGKoJNx9U2nbgQXgNO8qWo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-nGUTORE3N-C1TlkJkRwtEQ-1; Thu, 10 Sep 2026 13:36:29 -0400
X-MC-Unique: nGUTORE3N-C1TlkJkRwtEQ-1
X-Mimecast-MFC-AGG-ID: nGUTORE3N-C1TlkJkRwtEQ_1789061789
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so9410885a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789061789; x=1789666589; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2PZ/XuKVqhA3EBO7HvKnXNkby/fV3O74iWiuA0/KHA4=;
 b=oKOLcMs0m+0UhGx8cTtOccEMxcz3+hPhTBryXOBI+LPUcAX/OOXl8/tsrw0SBTt0u2
 NWtlcaDnuTR8wGmZedaxlTJv7jNEP/es15+t91kXBzQFCIip89dfnOxRF1v2si/4jbTb
 SQCZp16TiNsucKGEQIqlIyPCX8rkyWiZyen3661HuukNp7pFMedRl+1gTLWdDnyeZ45p
 /hoZP7qThWI/Yjvkpezn021D+NUBkTcRSYNkstGbS3qRdelCPovwS3WceF5YEf22g9Rv
 /2WwqIWjCiWc/RXYwtluYys+glKWbmcGCSjq16O53REgUtGSvbX+ADCgx2oM9tOnGXhx
 8Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789061789; x=1789666589;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2PZ/XuKVqhA3EBO7HvKnXNkby/fV3O74iWiuA0/KHA4=;
 b=LAPo735sEdE83bNE3X7sndwY34K8Yw0tAfpTTWxgcyqzgzTsSLrE++1miyoi8nyjC3
 XiUMRCrc26fWIIzL0Ngg9ayp8Bp7rlAJj4UgR/GVjcDw9L9vJi6hn/Z9uRcKwI2X+VNV
 p0HdGn0Xz9tb5jW11t4MZmfpMO8u7E1NyxUZvNkOEp5Sc0/Dz+96Cb4K3ihGwpcxIl3f
 BnMDHfa2CVOtrYyEFswiMoB3yvILj4sc3KL0GPMor0NtNtGC1/9ReTE7plvrom/663/5
 A2QrHCsCeMN68vlEjSh1+U6P4vkqJKx2wOjrxIFoFwaeXwT7VbooCTQh01pUFFxQ2QNT
 SKjA==
X-Gm-Message-State: AFuF++k9nfjbPCR/BYPQdlcj3Dj5TRHx24KVoUIC3V7NQa9uEVTNaNAT
 jHIpBHmzOzreXz2KFNWjIWQEGl6lI+YNH9EnzcSCMsrzX+9k4PIaU8DOXhPp15q9MP4lw7DhJaK
 KLUvh9RYTuVLWkZ/hbDkJgKSHAVBAC0Zl7toveQg4/b7hfpQkxM1tzbG8ZgTga7MyBKY=
X-Gm-Gg: AYBFou1+NGx11eGcJsOTuG7v6n2yrZuu5WoXJsAh6g66xTG6Ng/gdqZBDyzTHnMFGIp
 HxKsoxwdUgU4Cts8VC0ZW9VESVo3XrDktli9z2T+xC8eIudaOGPTCJ+O2sok5uuXYUvOw/V7vHN
 e+NpEDMcbNpxsDhbinS3lNtgUJIDJkQdypppu3kIHDN8TQtA49SSOcVbySe0NZ9evdlf/iL4mon
 fkWUx/J9zTYWD6Fsh8KJKC4/saiidpGKSWHl7nH3QUqzwsSk5Fy3YXKGWvxKG29qWEAWop5n6k4
 I3C0BtK4S+aCyWpGKSbcEZE1OyiU7Gv5b1xYgEc+F1elUPBhTA/ldCyla9ecSIHj1ho4GOWA6BC
 TiIofIOy26kv61G7Qe6e0qL6DsgIk7DJhXsFIjunpwsy7yvmTHgpAIe6DHIQ=
X-Received: by 2002:a05:620a:4594:b0:939:7e11:d2cf with SMTP id
 af79cd13be357-939d7f8788cmr708501085a.25.1789061788565; 
 Thu, 10 Sep 2026 10:36:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4594:b0:939:7e11:d2cf with SMTP id
 af79cd13be357-939d7f8788cmr708494085a.25.1789061788034; 
 Thu, 10 Sep 2026 10:36:28 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e86b7424sm25982085a.32.2026.09.10.10.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:36:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:36:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/18] tests/qtest/migration: Add a test for HMP
 completion
Message-ID: <aqLqmo8mEWAQAg7L@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 09, 2026 at 06:45:00PM -0300, Fabiano Rosas wrote:
> The following patches will touch HMP readline completion for migration
> parameters, add a test case.
> 
> The test puts the monitor on a chardev via socket and bypasses qtest
> facilities because it needs to emit raw codes to readline. It
> therefore requires a couple of new helpers to read/write to the
> monitor socket.
> 
> Usage:
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/completion
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


