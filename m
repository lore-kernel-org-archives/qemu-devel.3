Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C059CD15DBE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vfy-0005qt-Cy; Mon, 21 Oct 2024 12:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2vft-0005qI-HL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2vfr-0007sW-FQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729529667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVn9vmOHLhwH/Tj5FhoHsRnBhNXAYaGyHN/KyaqzXD8=;
 b=FiBS+qLtdRYd4H8zn5iQaefUHGWI37hHN/t0SAk/zJnyjS62Ee3t8U8hwBAnLKtP0GkBCw
 a4CWS05EgRro8X5wylbUmB3t4ek/FmfOAWznEvs6+jdVxLFQw+74kLFNhMFmXB6E9lY5oY
 5FC+losz+0PQd/KY0ZIpE2/Gcc1oFDI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-s6LTINmwOoetVHO3wCuVqg-1; Mon, 21 Oct 2024 12:54:25 -0400
X-MC-Unique: s6LTINmwOoetVHO3wCuVqg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf054c552so73534636d6.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729529665; x=1730134465;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YVn9vmOHLhwH/Tj5FhoHsRnBhNXAYaGyHN/KyaqzXD8=;
 b=sntsIdqxnQriQH+2B9y2jHjnDx1+37Ep19SAG6VIw9uYpPFACjlA6PfKjeOS1nQ6fh
 ZR6Iujj5e4mfxYp8i6nKzJkHCLyWPrxHBjWfWZOz3RqVjQzYhmtf76xS+1cs/1IyUTnd
 hKn03s/j7J/8J122jmSDrjHSfVCYOruR/31t5loPBr/LJ3JfOgCVlOMGQdi/zi8+DnTx
 hYmFVfQMfoWonR0bABSC1cnsW6yzK8aqlzlRNGfe9+tkBS+tnCOBQCED4b8t4VdzZple
 zFx8p6WEhH3+PRlJTHg6OPNI2Mqxg7m78X60vzX7KVwhCSZ3ECyqvchiYHnWrZFpM6he
 8DQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhsX55/c0N0KYQjP8yhvQrbNBnq2zj9WoQSurS5IZTBwtpH1l6hsdnmtSykUa8EdlUXGGJkXeVGRPW@nongnu.org
X-Gm-Message-State: AOJu0YywLJf7X6MnIAHwnHD0xykGhy98MagyO6K0UZveZ5EScBEA1fZs
 htVR8vbRfJVbrgRKRYHBggdHp/6Tb8Fj4iEUFvMZVUSZTR6k7ARW4CnvDxewlVQpVplerZavHrl
 SOgiexwdwGpU2XqWIiIrzTVusfTfo4CT3WvYFreiRsEtpI8gju9pO
X-Received: by 2002:a05:6214:5f0d:b0:6cb:e453:590 with SMTP id
 6a1803df08f44-6cde15f1d5amr210407806d6.37.1729529665206; 
 Mon, 21 Oct 2024 09:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOACHACU1xbBfz1LNzRDtmQrJY8yDQG5Q4d19dFGaoMG9fXQmNOEy/VUPrBY8fJdNabHCqGg==
X-Received: by 2002:a05:6214:5f0d:b0:6cb:e453:590 with SMTP id
 6a1803df08f44-6cde15f1d5amr210407476d6.37.1729529664857; 
 Mon, 21 Oct 2024 09:54:24 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008acc74sm19292886d6.21.2024.10.21.09.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:54:24 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:54:22 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
Message-ID: <ZxaHPo7GRPuby5ky@x1n>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
 <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
> Hello,
> 
> > IIUC the migration thread should always see valid migration object, as it
> > takes one refcount at the entrance of migration_thread():
> > 
> >      object_ref(OBJECT(s));
> 
> Could the migration have failed before ? in migrate_fd_connect()

I just noticed it's a vm state change notifier..

If so, maybe VFIO could refer to its internal states showing that it's
during a migration first (so as to guarantee the migration object is valid;
e.g., only after save_setup() but before save_cleanup() hooks are invoked).

Then migration_file_set_error() is only needed when it's during a migration
already.  Otherwise it's only a vm state change event, so nothing relevant
to migration.

-- 
Peter Xu


