Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28EEC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvMX-00055f-Nz; Fri, 30 May 2025 04:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMO-00053S-HV
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMM-0000fZ-4O
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748594699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4hUpmcrZ8Uos+TYIKZZ/7vLpNvWUVnBm81bPRlU9r7Q=;
 b=CW+UA0h9P1ZTck/2tOayOKc7DmfMY7HEuSG4+2meKVY5NcfEAazCXxw17f5J3wiv24hRh7
 SwhSBLzgQrNa83Kj6eFUlxqMtqRXaYTSyMjTMTi9DOAhEf1nCOCv8NLgF4O5Kqn5O/URon
 CBMyM6ZKspaeM46fCEsOgwVZYmh+aNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-kB-OhdcsNTmnttS0U-GpCQ-1; Fri, 30 May 2025 04:44:57 -0400
X-MC-Unique: kB-OhdcsNTmnttS0U-GpCQ-1
X-Mimecast-MFC-AGG-ID: kB-OhdcsNTmnttS0U-GpCQ_1748594697
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d9f96f61so2648685e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748594696; x=1749199496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hUpmcrZ8Uos+TYIKZZ/7vLpNvWUVnBm81bPRlU9r7Q=;
 b=XzTqJZYttMqXnEaMy8h3SK2tTBJBJUnpkIW9R/Sq0qhv/ft3iHVGjZinbQGN2l0tfJ
 EylaL2qQDQiPyLmzOq0SQaYAQHAjblW67xOQY6oKXiQhzqtUavehxFts/nm4lWyl93N3
 sNOyjFf/uYBUkyFBDCUqc5LoU1WZjW7VkuMBhO3UHED7LuQaSlN2p+3QgrykaYyQRt8e
 TTf9pLnHyrPd/R0yKwNJjrUFyXOmqyGuMB6ms9wxw+NY8zDXtrEFrromIB1aQkGuamFx
 BNjTX9Seeqn3fyOAY3OPxUR8xhQyKvsLbHaNYlAUry6e8Zq3M+Rk9OycZ7iHZiuYfeGE
 jlqw==
X-Gm-Message-State: AOJu0YxFKqEbPKaxgEFPGxElck3dYJKAvviOK7VZcQI0WwoZ3vjmDfRm
 o2RilZ+1RP+X/rrwCowXSklwl0S2jqNaheksDI6PuCnfrXMAxZhCKyzb6p4kL120KmJTjzM/+w5
 agHvxsaesQF0u3a6LKabht/UXluHioFNWGn6GLp334IlrmwF6s8+rZvtS
X-Gm-Gg: ASbGncsnbYOm7t94EARMvCZVtbQNGzxc/BLuwY2SNk0kQXQU75sxDlLSWXH5TFIucwY
 TjQarVqqhFriq9ge+tz4WJmFBSbkiD3Ez07H9jsXs/ohR3HpsFwlqfidNXIVRoFuqmqlrJ0/mKb
 1q6EM2Y0Nt9qOlu7HnmK6sUVYyqCr2EMhDHn0KCiZZiS66bhP74JtOYElYj/KTKmCWRelEJIZVz
 sxb7i/XjFZ2HyEQI2ToeNSqu8CJrNMxxWwOiKohj6wFxuCZ7orOqSLxoGZy1H2NR1Go03iNqWBk
 63bjsQge49yYv+EBOYs9V3yxl5gR6kbVddt3oc01zTjaK5Cv8b4DkyKwdG1h43iJILjQMA75d6H
 5w1Im
X-Received: by 2002:a05:600c:4d97:b0:441:b5cb:4f94 with SMTP id
 5b1f17b1804b1-450d64e2cf8mr14997045e9.5.1748594696606; 
 Fri, 30 May 2025 01:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwNhIuZfGFvlt6fAHXV0XcKLxkX+HP2bG6qhpWFcPoRqq2shG+eD1aXPQlvXVysvVczFH3Rw==
X-Received: by 2002:a05:600c:4d97:b0:441:b5cb:4f94 with SMTP id
 5b1f17b1804b1-450d64e2cf8mr14996965e9.5.1748594696264; 
 Fri, 30 May 2025 01:44:56 -0700 (PDT)
Received: from localhost
 (p200300cfd700f320acd9b9a35df3ddfd.dip0.t-ipconnect.de.
 [2003:cf:d700:f320:acd9:b9a3:5df3:ddfd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8edebsm11694075e9.6.2025.05.30.01.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:44:54 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/4] qcow2: Add keep_data_file command-line option
Date: Fri, 30 May 2025 10:44:43 +0200
Message-ID: <20250530084448.192369-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

This series adds a keep_data_file qemu-img create option to qcow2 that
makes it keep the given external data file for a newly created image
instead of overwriting it.

This allows to create a qcow2 image for an existing raw image using the
qemu-img create command, which previously wasn’t easily possible
(besides work-arounds using a temporary data file or qemu-img amend).

(The “proper” way of doing it without this option is to use QMP
blockdev-create.)

This new option is a pure qemu-img create (i.e. command-line) option,
not available via QMP, because it does not make any sense there.  See
patch 1 for more explanation.

(See https://issues.redhat.com/browse/RHEL-73509 for perhaps a bit more
context.)


Hanna Czenczek (4):
  qcow2: Add keep_data_file command-line option
  qcow2: Simplify size round-up in co_create_opts
  iotests/common.filter: Sort keep_data_file
  iotests/244: Add test cases for keep_data_file

 include/block/block_int-common.h |  1 +
 block/qcow2.c                    | 78 +++++++++++++++++++++++++++++---
 tests/qemu-iotests/082.out       | 18 ++++++++
 tests/qemu-iotests/244           | 71 +++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out       | 53 ++++++++++++++++++++++
 tests/qemu-iotests/common.filter |  2 +-
 6 files changed, 216 insertions(+), 7 deletions(-)

-- 
2.49.0


