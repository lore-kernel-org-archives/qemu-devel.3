Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B603F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtYL-0007yM-LK; Thu, 09 Apr 2026 13:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYG-0007y0-Av
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYD-0005EJ-Ht
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775757137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=02Ir0fymlEZqFzgOIna3LoFh7lLd5eUZppD4Uz+hsu8=;
 b=FowHOYKqB13JHEyEeRY5I9wvb1kV5cWQ1hizV+XHYOJHQ6Wb18Y9+UyQMYV0Fr6GB6GYsI
 RoccAoEo6PgYfZKYXounbSwScFjtQbC5eEtyCuBUFBSj5lBTXhVtdF6xKIo2Fk9+tOnybS
 8mU8zUEO3SUbOAJtpKz/CU+g70kwRQ0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Yj2dL934ORqYPx4HE5xfDg-1; Thu, 09 Apr 2026 13:52:15 -0400
X-MC-Unique: Yj2dL934ORqYPx4HE5xfDg-1
X-Mimecast-MFC-AGG-ID: Yj2dL934ORqYPx4HE5xfDg_1775757134
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bce224720d8so827231a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775757134; x=1776361934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=02Ir0fymlEZqFzgOIna3LoFh7lLd5eUZppD4Uz+hsu8=;
 b=YVPKpJKvGBOFqpCZUVDVYws0vwApQQZ1xE+TehQCrm7L1LNje1+439mHY6AeTEWoH/
 j5uzDBb77d1n4tPuPzuVDvhkg2tJdPjwj21jJsEp67G3Qu8ln5/pCbUsWZf3PrleHzJ6
 aw5WiRyTrT8mbBVLN4frCtTO3bBFQZt+lTYJcZZ0lGivTlX/4msrMpIcImsAdVxOl90r
 eoKP3eMksVDrYKHzvso/6loiCJ5Rtqd/8QRPOu7hl4ofiKb7nRn8ryt3FnMZZKMZvpOv
 c8VZE4wn7YIs9CRHsy63P9OU1IiUPJntkqfLtR0k010V+1N/8MIlIFO8upxBkOx3nwoC
 UuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775757134; x=1776361934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02Ir0fymlEZqFzgOIna3LoFh7lLd5eUZppD4Uz+hsu8=;
 b=qaiskfLWm58+xUE+CBBmqleyfFoDcQ3vNiBQN7BcMFYF3wEG951OtPrzY6sLRQX/Va
 UzU2bstVWFKGjvDW4eHjrRhp4KTdd7xK08dtECebG6WzFDOocV6U4x9lTbD0nGwVdOxz
 AA+7tcwN+LRldM5y0uknElT6tQwXQ1et9+biANaulg3K9bDF0meplW//a6xqNQ2eIZ28
 YsQR6Of7DPfsTYAS9Yy3OTewcX1e4J3LJ5E2Skt5YlsGFjNWys/fySi8eYAPSAwMAtd4
 Q05vPO6knHx77quhANZJ2OCcP2CdXNuGcFlfH1hE6DjEJOyK5sTRfvOSWXZxC43PSbQe
 Zn4A==
X-Gm-Message-State: AOJu0YyxOnZeXpic4LPOkgsGrseLFky/phP1CatxexayrehPmiu12AKs
 d/rOlX564UILgftGTYEiqJSAEeJa5mH0IygbEgbVQ6xoIIsq5rFKW2JF0GEaYyAYoTGJE0dkq1D
 BeZ3kFJUF+M8yGOOas2P+wuoe7Gh7qX9vS0D61CzjX/zE1mFVxcj6+C8I92Jd/a6/Bnr3hgfCw5
 Uosii6piL+mYA3XRp/ZdRtRgWEiJWh5lIoGTFVMnQ=
X-Gm-Gg: AeBDieslXMNe6/1EI9QlW18DmdhY+Mx3+Yao4qQON5IEBfcUujn/MBrybGRwdJ5qzKW
 xOxuPVBb41S7BqVG7mgqqfb8t8l6J4WkDQMF52G8QJrxUQaFz20kZ7Pd05VETLcbhoBZ7jLv4KL
 H5CnWJUzOf9RFeb4W25d+4HZSgEx4d2nlDW/Da8T08qFXPgzBPM7azfHLy1T+aYnxw8fVfjSXvQ
 LPH7VgRvk5jbv1dkyh9I28foxMQsqznW361ZAusgkYBeO8SqcAKX6/ob5sCtqZKPIQc5B0a/3Gr
 i73fxp/L2IzD7GWvwQ2PDzxFxduSXRgEQ0UAFaZPGZFlxB472qyrkFDofiYszXJNxIL8n9juOjJ
 bPyYho8xw6sNBU9tacFnfjNFqQltYr335K8gBe7iZ3OJJQMU2yiiWYa2Lek9GRq0=
X-Received: by 2002:a05:6a00:1c9b:b0:821:81ef:5de8 with SMTP id
 d2e1a72fcca58-82f0c273b40mr150916b3a.12.1775757133498; 
 Thu, 09 Apr 2026 10:52:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c9b:b0:821:81ef:5de8 with SMTP id
 d2e1a72fcca58-82f0c273b40mr150870b3a.12.1775757132613; 
 Thu, 09 Apr 2026 10:52:12 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c52cf05sm27736b3a.61.2026.04.09.10.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:52:12 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v2 0/2] migration/vmstate: Add VMState support to safely
 migrate GByteArray
Date: Thu,  9 Apr 2026 23:21:23 +0530
Message-ID: <20260409175126.5921-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This series adds a new VMState called VMSTATE_GBYTEARRAY, which will
directly use GLib library API calls to create, or resize the object.
This is then used in ui/vdaagent.c replacing the use of
VMSTATE_VBUFFER_ALLOC_UINT32.

Changes in v2:
- Marc-André pointed out the problem of not updating the device state
  itself. To do that we should essentially pass a pointer to the
  GByteArray pointer. Remove VMS_POINTER from VMSTATE_GBYTEARRAY. This
  changes 'pv' to be the address of the pointer field (GByteArray **)
  instead of the pointer's value.
- Update get_g_byte_array and put_g_byte_array to handle this additional
  level of indirection, allowing safe allocation and updating device state.
- Link to v1: https://lore.kernel.org/all/20260406115247.4879-1-armenon@redhat.com/

Arun Menon (2):
  migration/vmstate: Add VMState support for GByteArray
  ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate outbuf

 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
 ui/vdagent.c                | 13 +------------
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.53.0


