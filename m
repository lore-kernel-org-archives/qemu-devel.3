Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F80C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 02:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJlOA-0003dH-EW; Tue, 18 Jun 2024 22:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sJlO6-0003cX-Ue
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:49:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sJlO3-0006E4-Oi
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:49:30 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57c68c3f8adso7385098a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718765363; x=1719370163; darn=nongnu.org;
 h=cc:to:subject:message-id:date:user-agent:mime-version:from
 :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=KByKPKbMrEO1XASLvRKDaZcgEq8T7PpYzMvojaXKfAk=;
 b=lhOGrF+AmR1NZYVqU705zZ22cBcKKQQlf7Odt38Iy7hsHxiIGIbOVFYfhS3McQS6hK
 /Px6v9eliuOZEMKf1DLVEAWPqbzZl8Z3UQsfMWLJ9LJrRbg/b1Rgzyhse/jVFPrD6ePX
 ElOezbs1at9NuPBtz3KHFQrG8e3YWQDczsBDQDwdXl4DBRaava+vpVdfHfdhvNjcKthy
 surVvaoHkpdfBzeceQTnF2YU7Jdni10n9eInq0z9Q8OaVWZwcz4kvMXHZ7VmhYbQf67q
 DUkgqvfTcnmSfnNTX5G9nYKN8AQsXteXoX5NbDJ6OvyB3ICmLe6RK0CfCnyQvDKqs8Y7
 uxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718765363; x=1719370163;
 h=cc:to:subject:message-id:date:user-agent:mime-version:from
 :references:in-reply-to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KByKPKbMrEO1XASLvRKDaZcgEq8T7PpYzMvojaXKfAk=;
 b=oMXRcmYlu4vRYRT1BoBJLSJaCp9RuzrFdLpQn4ieLUJJNbwDDuTiMiHwxRFBMyjtg7
 yF6cKOunQjNWu/ykvpjk29oguM0MN/kYiS2HETzmrLxZkP0PUzWDur0U0VBuVOUOKDWK
 +fn/s8UOUaCZTtfKaYOTruLQT8yuEu9YRzQe20CS3XLqsSEK+xqf0VX/DpdOzE7LLZcR
 y0hJ37at/LZ5xnykhQEdZT77N41b5Iu1qbuQZzB9GSc+QsfFrB7nAto0sc2KIj1cPz3Q
 cG7ThYjIQUoRJgaPXB2+G8B+/w5Z6oSf8lb7mCYN21tirgmvBEx6nXQ8aKpSTOROw9Gm
 jQrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxl6cbxOigTSkIJrVp2kxzQw5OIx7J2YQRdUT+Jwyt9T2JOTnHtSPYXhyWgYlokRekMajEUkoNW7eRLGc1LSycH4qy3dA=
X-Gm-Message-State: AOJu0Yyj278UlQeaAAsXkniwRntYu06Stjdbhs7vV8SVE/7EJzvkazVN
 l3sYeZcMNnbZSq26pNiZMZ/QlWMHFFOlyvDBrM2ZmH/MXMLNOjm7KUujIBMijt5uSEYLMXkcTwK
 z/390aE/lw10xVvZcllNU+wYUHcZRym6tqmGnHg==
X-Google-Smtp-Source: AGHT+IETjPJ9MPs35q2GusBMk7XJ5fO6ACevZwHdR39KEKGqPHEgsNX70j7a1nxQN5FwNPfq8zSoTH6D+8qBAWj6HTk=
X-Received: by 2002:a05:6402:1605:b0:57d:b18:a0 with SMTP id
 4fb4d7f45d1cf-57d0b1800d5mr596595a12.15.1718765363503; Tue, 18 Jun 2024
 19:49:23 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 18 Jun 2024 19:49:22 -0700
In-Reply-To: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Date: Tue, 18 Jun 2024 19:49:22 -0700
Message-ID: <CAO5cSZDj=8Ehy11Pgz7AEEYdzsB-rK_E4LUX8DW5V38hYr0r2Q@mail.gmail.com>
Subject: PING: [PATCH v6 00/10] Support persistent reservation operations
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000f1c1ae061b353ece"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000f1c1ae061b353ece
Content-Type: text/plain; charset="UTF-8"

Hi,

Klaus, the pr related operations of the
nvme layer are almost ready.

Stefan, the block layer has been modified
according to your comments.

Please help review the code again. Thanks!

On 2024/6/13 15:13, Changqi Lu wrote:
> Hi,
>
> patch v6 has been modified.
>
> v5->v6:
> - Add relevant comments in the io layer.
>
> v4->v5:
> - Fixed a memory leak bug at hw/nvme/ctrl.c.
>
> v3->v4:
> - At the nvme layer, the two patches of enabling the ONCS
> function and enabling rescap are combined into one.
> - At the nvme layer, add helper functions for pr capacity
> conversion between the block layer and the nvme layer.
>
> v2->v3:
> In v2 Persist Through Power Loss(PTPL) is enable default.
> In v3 PTPL is supported, which is passed as a parameter.
>
> v1->v2:
> - Add sg_persist --report-capabilities for SCSI protocol and enable
> oncs and rescap for NVMe protocol.
> - Add persistent reservation capabilities constants and helper functions
for
> SCSI and NVMe protocol.
> - Add comments for necessary APIs.
>
> v1:
> - Add seven APIs about persistent reservation command for block layer.
> These APIs including reading keys, reading reservations, registering,
> reserving, releasing, clearing and preempting.
> - Add the necessary pr-related operation APIs for both the
> SCSI protocol and NVMe protocol at the device layer.
> - Add scsi driver at the driver layer to verify the functions
>
> Changqi Lu (10):
> block: add persistent reservation in/out api
> block/raw: add persistent reservation in/out driver
> scsi/constant: add persistent reservation in/out protocol constants
> scsi/util: add helper functions for persistent reservation types
> conversion
> hw/scsi: add persistent reservation in/out api for scsi device
> block/nvme: add reservation command protocol constants
> hw/nvme: add helper functions for converting reservation types
> hw/nvme: enable ONCS and rescap function
> hw/nvme: add reservation protocal command
> block/iscsi: add persistent reservation in/out driver
>
> block/block-backend.c | 403 +++++++++++++++++++++++++++
> block/io.c | 163 +++++++++++
> block/iscsi.c | 443 ++++++++++++++++++++++++++++++
> block/raw-format.c | 56 ++++
> hw/nvme/ctrl.c | 326 +++++++++++++++++++++-
> hw/nvme/ns.c | 5 +
> hw/nvme/nvme.h | 84 ++++++
> hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++
> include/block/block-common.h | 40 +++
> include/block/block-io.h | 20 ++
> include/block/block_int-common.h | 84 ++++++
> include/block/nvme.h | 98 +++++++
> include/scsi/constants.h | 52 ++++
> include/scsi/utils.h | 8 +
> include/sysemu/block-backend-io.h | 24 ++
> scsi/utils.c | 81 ++++++
> 16 files changed, 2237 insertions(+), 2 deletions(-)
>

--000000000000f1c1ae061b353ece
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>Klaus, the pr related operations of the
<br>nvme layer are almost ready.
<br>
<br>Stefan, the block layer has been modified
<br>according to your comments.
<br>
<br>Please help review the code again. Thanks!
<br>
<br>On 2024/6/13 15:13, Changqi Lu wrote:
<br>&gt; Hi,
<br>&gt; 
<br>&gt; patch v6 has been modified.
<br>&gt; 
<br>&gt; v5-&gt;v6:
<br>&gt; - Add relevant comments in the io layer.
<br>&gt; 
<br>&gt; v4-&gt;v5:
<br>&gt; - Fixed a memory leak bug at hw/nvme/ctrl.c.
<br>&gt; 
<br>&gt; v3-&gt;v4:
<br>&gt; - At the nvme layer, the two patches of enabling the ONCS
<br>&gt;   function and enabling rescap are combined into one.
<br>&gt; - At the nvme layer, add helper functions for pr capacity
<br>&gt;   conversion between the block layer and the nvme layer.
<br>&gt; 
<br>&gt; v2-&gt;v3:
<br>&gt; In v2 Persist Through Power Loss(PTPL) is enable default.
<br>&gt; In v3 PTPL is supported, which is passed as a parameter.
<br>&gt; 
<br>&gt; v1-&gt;v2:
<br>&gt; - Add sg_persist --report-capabilities for SCSI protocol and enable
<br>&gt;   oncs and rescap for NVMe protocol.
<br>&gt; - Add persistent reservation capabilities constants and helper functions for
<br>&gt;   SCSI and NVMe protocol.
<br>&gt; - Add comments for necessary APIs.
<br>&gt; 
<br>&gt; v1:
<br>&gt; - Add seven APIs about persistent reservation command for block layer.
<br>&gt;   These APIs including reading keys, reading reservations, registering,
<br>&gt;   reserving, releasing, clearing and preempting.
<br>&gt; - Add the necessary pr-related operation APIs for both the
<br>&gt;   SCSI protocol and NVMe protocol at the device layer.
<br>&gt; - Add scsi driver at the driver layer to verify the functions
<br>&gt; 
<br>&gt; Changqi Lu (10):
<br>&gt;   block: add persistent reservation in/out api
<br>&gt;   block/raw: add persistent reservation in/out driver
<br>&gt;   scsi/constant: add persistent reservation in/out protocol constants
<br>&gt;   scsi/util: add helper functions for persistent reservation types
<br>&gt;     conversion
<br>&gt;   hw/scsi: add persistent reservation in/out api for scsi device
<br>&gt;   block/nvme: add reservation command protocol constants
<br>&gt;   hw/nvme: add helper functions for converting reservation types
<br>&gt;   hw/nvme: enable ONCS and rescap function
<br>&gt;   hw/nvme: add reservation protocal command
<br>&gt;   block/iscsi: add persistent reservation in/out driver
<br>&gt; 
<br>&gt;  block/block-backend.c             | 403 +++++++++++++++++++++++++++
<br>&gt;  block/io.c                        | 163 +++++++++++
<br>&gt;  block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
<br>&gt;  block/raw-format.c                |  56 ++++
<br>&gt;  hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
<br>&gt;  hw/nvme/ns.c                      |   5 +
<br>&gt;  hw/nvme/nvme.h                    |  84 ++++++
<br>&gt;  hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
<br>&gt;  include/block/block-common.h      |  40 +++
<br>&gt;  include/block/block-io.h          |  20 ++
<br>&gt;  include/block/block_int-common.h  |  84 ++++++
<br>&gt;  include/block/nvme.h              |  98 +++++++
<br>&gt;  include/scsi/constants.h          |  52 ++++
<br>&gt;  include/scsi/utils.h              |   8 +
<br>&gt;  include/sysemu/block-backend-io.h |  24 ++
<br>&gt;  scsi/utils.c                      |  81 ++++++
<br>&gt;  16 files changed, 2237 insertions(+), 2 deletions(-)
<br>&gt;</p>

--000000000000f1c1ae061b353ece--

