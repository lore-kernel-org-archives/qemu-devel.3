Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368DDE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVEvv-0000Mp-3p; Tue, 07 Jan 2025 14:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tVEvs-0000MZ-Ih
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tVEvr-0005wQ-03
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736276882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6N+MDNfhqEWSldmyBSY1nNns1pi99KQqXGHwXf1lOY=;
 b=Kv3XQn3lPDX+GS+XWmKwpdfOhFWda/xjTu4uNuf1JKxBkRzj/NscJT2N+WJ3a2LIYrp2Ax
 PJhJBNEtt0SXnTAPHcwGUoAF3CS2+0U+8mk/Ox6UiCjX2jMOB3eBLbC4AeOmIQXJ3ETWPc
 fF/Ny3aJHsF02VuhP/dUAKsA8nxXyjM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-helW-Y2SMJOThyFM4b1efg-1; Tue, 07 Jan 2025 14:06:42 -0500
X-MC-Unique: helW-Y2SMJOThyFM4b1efg-1
X-Mimecast-MFC-AGG-ID: helW-Y2SMJOThyFM4b1efg
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-844df5d5edfso114841439f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 11:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736276802; x=1736881602;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e6N+MDNfhqEWSldmyBSY1nNns1pi99KQqXGHwXf1lOY=;
 b=KI+gwCh105nSrbd+eGodXk9qHJHXSgXv6sUZRB7e5rspv5yQdfGiLrJSE/OcDey12j
 TmaODDWXALVq8Fl10hNb3EnaUxqBY8gRAGyO6fEHVjJL4s3G5OT2gsCBDa9NAB6Frvk/
 e95U9yE4W+IwcEsvje3byZ9bAm0sNMhtExrint6ZG9vAKwu40QLCP7cUb7Sdrl9QDewL
 lAYCp4mCWKPtqJnPvsx7Gd2zT2Nux5dS0RLg2QrsaYZEteW40Afi/U6CXEeF/Nml01CU
 fAT3JYamc6FQ8tz37/YCslQeqqf24l6YRV3urK/yIWRXbPlRCQCrhrtDETl5atuIriHk
 dTsg==
X-Gm-Message-State: AOJu0YwRjaZkeisHQaY78KS986kLG4CJOhj+zST2LJ7o+JCaBA3xne6n
 cO1iRMCbTJDLCLywyjfzOoRp0mGO4orVjQBL4VTwd8WaF9s1IbUhVez0YZnOrRNWn+sVcc6vaHU
 07eZfzzGONIYSWKzkzli5ocdQdwUVUpKwNmVnZ1RF2XaYvh4d9TT/
X-Gm-Gg: ASbGncue4a8SLIckgcUNdJJQVgbcTltSwbSu+Z2vlqZTiqx0px3fBk+jO9wb5N7VFYx
 NIX2+dTQ2pYVtbf4LrYA3pM+FWG3lFuIBYP5syHlUE6PM33P3/X9S8zK17/OdIF0ZhO+1RJgrcP
 5thIZg9toGTY1uvi/zaf986d9ZwcosKfTXk7K4S2wqKMXPbzomYAL4gVoqQuRNQXopffiQVcH7B
 wnQNM57dF7zLw/UUikybR+/az4ULKfrzsrmo0YjxVgMWsxqwmK/LBxIZ0z6
X-Received: by 2002:a05:6e02:1f05:b0:3a7:e7bd:9f30 with SMTP id
 e9e14a558f8ab-3ce3a86aaadmr949465ab.2.1736276801516; 
 Tue, 07 Jan 2025 11:06:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFurqoZehh6ETJcqNQf2m661gzblrt8qa1LeuOAB0NVJKyEs82GAel/K/ZDiyH+6PD5qR3ng==
X-Received: by 2002:a05:6e02:1f05:b0:3a7:e7bd:9f30 with SMTP id
 e9e14a558f8ab-3ce3a86aaadmr949365ab.2.1736276801232; 
 Tue, 07 Jan 2025 11:06:41 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0de053105sm101468715ab.15.2025.01.07.11.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 11:06:40 -0800 (PST)
Date: Tue, 7 Jan 2025 14:06:34 -0500
From: Alex Williamson <alex.williamson@redhat.com>
To: Rorie Reyes <rreyes@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 borntraeger@linux.ibm.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: Re: [PATCH v1 0/5] Report vfio-ap configuration changes
Message-ID: <20250107140634.35cb33ba.alex.williamson@redhat.com>
In-Reply-To: <20250107184354.91079-1-rreyes@linux.ibm.com>
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  7 Jan 2025 13:43:49 -0500
Rorie Reyes <rreyes@linux.ibm.com> wrote:

> This patch series creates and registers a handler that is called when
> userspace is notified by the kernel that a guest's AP configuration has
> changed. The handler in turn notifies the guest that its AP configuration
> has changed. This allows the guest to immediately respond to AP
> configuration changes rather than relying on polling or some other
> inefficient mechanism for detecting config changes.

Why are configuration changes to the device allowed while the device is
in use?

Would a uevent be considered an inefficient mechanism?  Why?

Thanks,
Alex


