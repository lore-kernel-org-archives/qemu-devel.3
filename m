Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F66C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyYJ-0008FJ-4J; Fri, 30 May 2025 08:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyYF-0008DO-Hh
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyYD-0004uy-Pr
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748606969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y36I0mm1fE8F59v3MNks+MQO5UzMqRoWnWNZcNkjuNY=;
 b=HRvL30jYa6E/jJpw1Yhz3Wu2dDxGy8K9dMOqqtMA/kcW7oEFC5qoMENKxQthdEeVhtgTAz
 VsKeaqhOA7v6qyuSxm8ojSRTFF30a/qL8Sy0JwMcMIhxNjk7FRTe1Xp7/4s49ieAaDdk4A
 3E7/HfnmYazbXsJI1oRM/WNzrWaK2G8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-0d2pOqJTOYWL1xNwmZaBEQ-1; Fri, 30 May 2025 08:09:27 -0400
X-MC-Unique: 0d2pOqJTOYWL1xNwmZaBEQ-1
X-Mimecast-MFC-AGG-ID: 0d2pOqJTOYWL1xNwmZaBEQ_1748606966
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so142724f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606966; x=1749211766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y36I0mm1fE8F59v3MNks+MQO5UzMqRoWnWNZcNkjuNY=;
 b=MGajt7Qj8WPadfJBHRiKhvENhEDHVaC8/BcezCyab/OXo/G8DT1onaDOB8nfx4ysLT
 tshwAzP70kVz6tsiuS33zd1j7Bj/dQYLiAH19BOWHI8P5F34/eF1E2nkC6xrsOv2cX0y
 RhN8bzvm1H90Y8vVA4tdnRgVk7ZQs4YO+6h0Vv5L0pZUPpm0WiJvrSK7DxBj0M9thih+
 p083oBqYF+WnXtOpG4s+9hbajDoPlpzJORVdK/zvtpnrJR8wAQVgvAetReDl/trenfpY
 eI95DtXJRFr8KwU/s+WULz8iZQofnLAciwprG5Drxm9o2MyvPjv3py5K6qN+ZYY0bvAv
 9D+w==
X-Gm-Message-State: AOJu0YwvOmSKRR1BHG+byGvtmBqxwLzY9fYZPOzr6PYNVW+4Da2OBEAn
 /clxmn3YaqMf8zYQbTJEAS0sjh4FGQuObVs2t0iKnujxXUzfFHB/sggGJg+IfeIrVWAawke0peU
 hYrGO6WTSdBi3B6kK1mfzyQLlUg7vHvJm3/+7il7m0a2+VAyJ2zOIiSmB
X-Gm-Gg: ASbGnctkPPiikjr7jw/Q0dXlZQercZfVV4UJJ3LuPnShUeFb6lmEv/KnqdKIyxYOREW
 /7N6vF2n9V5lyJoeOdPT2ecnaGYsIbJAyuzQBhd4makv+88PlG77tU9q8g0vZkHQ8eroeg0dzWG
 zZcTWoJBjH0re3HF0h9VJiQ5SGxa1bei9vps2ipiGo5qaDFAc3+6js6qBbCNytjT35pOx14mw4B
 1ddwnqEsTpF8743DybH/pE3gLiIcetYRF0yW3CIaKRT+u7wB5F2hlq6/T7NT4+8fH36iKYlRMdE
 LgQNyg==
X-Received: by 2002:a5d:64ed:0:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a4f7a3baa5mr2364553f8f.8.1748606966327; 
 Fri, 30 May 2025 05:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHpmPiSVjIeMfszOTcwlCD8JLRILKP2Abehpiig7iFqcfCFQvkdj/a/1cBHrDo1Mhl0JtX0w==
X-Received: by 2002:a5d:64ed:0:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a4f7a3baa5mr2364504f8f.8.1748606965837; 
 Fri, 30 May 2025 05:09:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a00d4sm4694585f8f.92.2025.05.30.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:09:25 -0700 (PDT)
Date: Fri, 30 May 2025 08:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 0/4] qapi: add auto-generated return docs
Message-ID: <20250530080853-mutt-send-email-mst@kernel.org>
References: <20250523182442.54469-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182442.54469-1-jsnow@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, May 23, 2025 at 02:24:38PM -0400, John Snow wrote:
> v3: rebased on top of python-qapi-linting (v4) pull request;
>     removed commits that are no longer needed.
>     Markus: I forget where we left off... shall we refresh?
> 
> v2: fix multi-return-sections bug :(


LGTM
My bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge


> John Snow (4):
>   docs/qapi-domain: add return-nodesc
>   docs, qapi: generate undocumented return sections
>   qapi: remove trivial "Returns:" sections
>   qapi: rephrase return docs to avoid type name
> 
>  docs/devel/qapi-domain.rst | 30 ++++++++++++++++++++++++++++++
>  docs/sphinx/qapi_domain.py |  8 ++++++++
>  docs/sphinx/qapidoc.py     | 14 ++++++++------
>  qapi/audio.json            |  2 --
>  qapi/block-core.json       | 14 +++-----------
>  qapi/block-export.json     |  2 +-
>  qapi/block.json            |  2 +-
>  qapi/char.json             |  8 --------
>  qapi/control.json          |  5 ++---
>  qapi/cryptodev.json        |  2 --
>  qapi/dump.json             |  5 ++---
>  qapi/introspect.json       |  6 +++---
>  qapi/job.json              |  2 +-
>  qapi/machine-target.json   |  9 +++------
>  qapi/machine.json          | 22 ----------------------
>  qapi/migration.json        | 12 ------------
>  qapi/misc-target.json      | 14 +-------------
>  qapi/misc.json             | 12 ++----------
>  qapi/net.json              |  2 +-
>  qapi/pci.json              |  2 +-
>  qapi/qdev.json             |  3 +--
>  qapi/qom.json              |  8 +++-----
>  qapi/rocker.json           |  4 ----
>  qapi/run-state.json        |  2 --
>  qapi/stats.json            |  2 +-
>  qapi/tpm.json              |  4 ----
>  qapi/trace.json            |  2 +-
>  qapi/ui.json               | 10 +---------
>  qapi/virtio.json           |  8 +++-----
>  qapi/yank.json             |  1 -
>  scripts/qapi/parser.py     | 15 +++++++++++++++
>  scripts/qapi/schema.py     |  3 +++
>  32 files changed, 95 insertions(+), 140 deletions(-)
> 
> -- 
> 2.48.1
> 


