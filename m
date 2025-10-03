Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF2DCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv8-0005Vw-0y; Fri, 03 Oct 2025 11:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hus-0005Ps-RN
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htz-0007lM-Mh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oM2AWSLiQZGb8fxPI6CqnXRDla7vwEgPwRJUrjr487k=;
 b=FQiwMqYIfXBwQsf2eyRj9Y3sLc7oAWGGEKe+7AZVuoH4YzN9j/Zgb16IIK/PGRjYZJWLHy
 kOwIUeEKOE3HM1IsoNnMu2q8CrlmACuhkHvGC+BOy7Vu56KoDDniKHO/RgQ/YJ/3MUuKRD
 2jm+pkJ9CvXhfgDrsysO1WOIzL0s3kU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-dlXDQEPRO86wEdnJMJYoTg-1; Fri, 03 Oct 2025 11:40:53 -0400
X-MC-Unique: dlXDQEPRO86wEdnJMJYoTg-1
X-Mimecast-MFC-AGG-ID: dlXDQEPRO86wEdnJMJYoTg_1759506053
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78ea15d3583so48508816d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506053; x=1760110853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oM2AWSLiQZGb8fxPI6CqnXRDla7vwEgPwRJUrjr487k=;
 b=qqLhIzFrto7SDnveUyJOgiyQEbRAszGpdf4NcWIJLSYxkBU0gp4eDo3x5Y+4NE8qEk
 yY76nUo6gWcs+H9Bjoa+J8iUEEKPhTEi6I+X011TX6EjXpuBTrX0rIV/SkVRPmqHkpWn
 xmD33C+8wwrtv5OleCsrtnXUCdgVeUYi+e+9LD9zJnZ5CZ6KDYxXSOFWVA48DQuLVSrz
 mHQXXsni+ZhJNrVJz1Xyk9pu7mEZemG1qqsALnmN+gLTPD7hgGJijlxi2uF/bIzuIaFg
 pH9szPNk66Z0RisKEOwjNzc45pQhFzC0TVDRHatDRIQ9OZ3kqlaM1cTQol1Daz2+TLhP
 2HFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdfos0ceY5dSoKHxArwmZr/JHtGiOJHgH0axxM31XMBbVSFQZTRrjuB04zXrcSkQvZm2uJOdI7rU9U@nongnu.org
X-Gm-Message-State: AOJu0Yx+lLf0uT2+XD3rzO4pQF6b4X5sBLjxBWkbngVsE0Uz3lCbJGa7
 0OAnVIRTOs/mDkOPQLeP/O4/cbYo2V8Vl0UK6z/xAg4xtzYZQg6pqgvU8ZYbwYw6M35EYuv0tnK
 Pnhgc0mGtGVKt1TDFKzCaRZek7uNzrttKjstfuG7tJ7pgxlGG25RCVO/p
X-Gm-Gg: ASbGncvpeL7ISqgdJDmYr8N1FY8jTrpMsE/uFvSQcRUvX04P6dgRDYvs9YGnsEQeze2
 r0dGRlFJacB1rP8iqKFFYxQszxYTvwts2DCpgTxC5j4smWA54NinPZejuXwCzmWoBZC1YqRXfAQ
 GbaJi0KLaHK0A5zv6TBRkkGndQjggvdigleFu32anWOnLm+i3iaysLOFn8A+306dFA20oVw1q5L
 AKjhXksw4a3aFOzu86y4SuGgVQ76G+Ll7MLrc6r2zUuvCA9tPXtgUWyAL4zZCuxR3PsvBPXob4x
 5UJMgLDrjsW9es7wf0zfQ7/Ks2uBGOuYaPZF8w==
X-Received: by 2002:ad4:5cee:0:b0:84d:5b71:8a7f with SMTP id
 6a1803df08f44-879dc864aafmr53942196d6.34.1759506053121; 
 Fri, 03 Oct 2025 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOJejnt6bEiyXMYVus4Qmlvl6NgbZpQ62u6uBd6SSTQCQKbfZQ1CAcAS5J/VuaesMaqM2u1w==
X-Received: by 2002:ad4:5cee:0:b0:84d:5b71:8a7f with SMTP id
 6a1803df08f44-879dc864aafmr53941496d6.34.1759506052518; 
 Fri, 03 Oct 2025 08:40:52 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 43/45] migration: cpr-exec docs
Date: Fri,  3 Oct 2025 11:39:46 -0400
Message-ID: <20251003153948.1304776-44-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Update developer documentation for cpr-exec mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1759332851-370353-8-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/CPR.rst | 112 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 0a0fd4f6dc..b6178568a8 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
 VM is migrated to a new QEMU instance on the same host.  It is
 intended for use when the goal is to update host software components
 that run the VM, such as QEMU or even the host kernel.  At this time,
-the cpr-reboot and cpr-transfer modes are available.
+the cpr-reboot, cpr-transfer, and cpr-exec modes are available.
 
 Because QEMU is restarted on the same host, with access to the same
 local devices, CPR is allowed in certain cases where normal migration
@@ -324,3 +324,113 @@ descriptors from old to new QEMU.  In the future, descriptors for
 vhost, and char devices could be transferred,
 preserving those devices and their kernel state without interruption,
 even if they do not explicitly support live migration.
+
+cpr-exec mode
+-------------
+
+In this mode, QEMU stops the VM, writes VM state to the migration
+URI, and directly exec's a new version of QEMU on the same host,
+replacing the original process while retaining its PID.  Guest RAM is
+preserved in place, albeit with new virtual addresses.  The user
+completes the migration by specifying the ``-incoming`` option, and
+by issuing the ``migrate-incoming`` command if necessary; see details
+below.
+
+This mode supports VFIO/IOMMUFD devices by preserving device
+descriptors and hence kernel state across the exec, even for devices
+that do not support live migration.
+
+Because the old and new QEMU instances are not active concurrently,
+the URI cannot be a type that streams data from one instance to the
+other.
+
+This mode does not require a channel of type ``cpr``.  The information
+that is passed over that channel for cpr-transfer mode is instead
+serialized to a memfd, the number of the fd is saved in the
+QEMU_CPR_EXEC_STATE environment variable during the exec of new QEMU.
+and new QEMU mmaps the memfd.
+
+Usage
+^^^^^
+
+Arguments for the new QEMU process are taken from the
+@cpr-exec-command parameter.  The first argument should be the
+path of a new QEMU binary, or a prefix command that exec's the
+new QEMU binary, and the arguments should include the ''-incoming''
+option.
+
+Memory backend objects must have the ``share=on`` attribute.
+The VM must be started with the ``-machine aux-ram-share=on`` option.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-exec``.
+  * Set the ``cpr-exec-command`` parameter.
+  * Issue the ``migrate`` command.  It is recommended that the URI be
+    a ``file`` type, but one can use other types such as ``exec``,
+    provided the command captures all the data from the outgoing side,
+    and provides all the data to the incoming side.
+
+Incoming:
+  * You do not need to explicitly start new QEMU.  It is started as
+    a side effect of the migrate command above.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Example 1: incoming URI
+^^^^^^^^^^^^^^^^^^^^^^^
+
+In these examples, we simply restart the same version of QEMU, but in
+a real scenario one would set a new QEMU binary path in
+cpr-exec-command.
+
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+
+Example 2: incoming defer
+^^^^^^^^^^^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming defer
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  status: paused (inmigrate)
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: running
+
+Caveats
+^^^^^^^
+
+cpr-exec mode may not be used with postcopy, background-snapshot,
+or COLO.
+
+cpr-exec mode requires permission to use the exec system call, which
+is denied by certain sandbox options, such as spawn.
+
+The guest pause time increases for large guest RAM backed by small pages.
-- 
2.50.1


