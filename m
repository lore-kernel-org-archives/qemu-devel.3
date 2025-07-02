Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2E1C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWymi-000710-V2; Wed, 02 Jul 2025 10:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWymh-0006zC-Cq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWymc-0000JK-6G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751467795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sf3oJZLMC2D3+VL8xtFkKsoM+gLO6JyHNOC5V8fQv4A=;
 b=K21lYW6SlVyGFqSd4c0dJe76y36nzsdwpRL5I6v+v1Wcm3lYYAIV0HA3XVtcQnf27qzEgn
 ox+yMT5gi7GtOaHy7apF1rhrgO2X0pWTGLpAL5Wr+5y0oi65nhTC0TxSUH6VGOLOruRoD8
 oMzk88yuOUAh/NaAV+BjKKLpNAOWwv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-VM2jlKaJMYOFKswya2ppDw-1; Wed, 02 Jul 2025 10:49:53 -0400
X-MC-Unique: VM2jlKaJMYOFKswya2ppDw-1
X-Mimecast-MFC-AGG-ID: VM2jlKaJMYOFKswya2ppDw_1751467793
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so34730705e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467792; x=1752072592;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf3oJZLMC2D3+VL8xtFkKsoM+gLO6JyHNOC5V8fQv4A=;
 b=fVHAv/PG3olGEMJk9J48T/14RNqmvsHkP88rD8OmrJMwrFDc06pWZObhIbPT5xBSZr
 CrbdD5vrcfkDJD8HFdI1BvQGc6bA5GmvtLEhgMqs/PvNLzxyZMSlzz9BRIMtUtwXBx//
 MOEei/bCWGS6aF4qzMcWTKnO64miH7xOeiJPXXcMUj7FFxSCc98B+/9i8mpOFcPlKZ8h
 nYCJLD82QpmxJdO0nN3+2S6pNtelE6Dh8MYEuZgQCy8kg/ItnWpqXzhswOycQL7rYsvp
 QjVUbjbFJqGtcuLXwfUQuOyjZaYXc07W9PRjzciD5HsNT1KE8HMlmBIOVBH8f2E/a8UL
 ra0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKZlQSVZkTLHJ1tdsEiPrII0PyL3S+10piFpaRSuVaiLVGYWNZ87vc5eKATYRa2uPyWi6Kp+O2STme@nongnu.org
X-Gm-Message-State: AOJu0YxhVnUG7hXsvGP13lYLwwZ2ha8CQgDX0FWfERB2vcH3Gk1bX0T/
 a71H4zs25LhOz/qzWOZHt2TZOvYuIzr2KZ1SoR6g92QM7h9f8T1l8KozARgCv3KGjfOz2DJpjLC
 VtGMCdAB41kkuWCW81CqURPXTZMEOypWkkR6n+OjerFg2aN94SfclaZWT
X-Gm-Gg: ASbGncu+nhm8Q0hMW9J0aZ0O2RIyIzt5eFMiX4OSW3CWhHKjv6nPpi+F9T8tJjNSCtm
 u4hKxM4+ajO5LWicpVPDlHYr675WFqey3OKx4KM+oRTU0NgMaiyC/2JRwfvXq0pOoGnqybMByMJ
 xGv6OASZMW1Moefd7X3caN5idHISYZgnBzHXNhm2X6k3roLuNLjMAx+W9BTwsPh5VzPqOeti32q
 JwpkUMSsM5v01AZEBzD03jTT/PYDz3uLieD9zmsyzpvPkHvT1nCHNj4ZnQ9JdS5oCa3+mYn8xVo
 VZMsa2hKinqm9z2qEBsGpW8BgCJXDVbZkZs2++uyzb1XBhzn9U4Q3RCO7zKB
X-Received: by 2002:a05:600c:37c6:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-454a37261e6mr33467125e9.27.1751467792487; 
 Wed, 02 Jul 2025 07:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWGGNe+G+hAKbywqr58X5NVYaJ1U4Y+zlBIgHY1dR3Vux+MMly5aRU0yEUivb7YnOV9Zt14w==
X-Received: by 2002:a05:600c:37c6:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-454a37261e6mr33466815e9.27.1751467791994; 
 Wed, 02 Jul 2025 07:49:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcebf7sm58305e9.21.2025.07.02.07.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:49:50 -0700 (PDT)
Message-ID: <e7751172-0aec-4c83-878d-a2b7299dd945@redhat.com>
Date: Wed, 2 Jul 2025 16:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 38/38] vfio: doc changes for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/10/25 17:39, Steve Sistare wrote:
> Update documentation to say that cpr-transfer supports vfio and iommufd.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/CPR.rst | 5 ++---
>   qapi/migration.json          | 6 ++++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 7897873..0a0fd4f 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -152,8 +152,7 @@ cpr-transfer mode
>   This mode allows the user to transfer a guest to a new QEMU instance
>   on the same host with minimal guest pause time, by preserving guest
>   RAM in place, albeit with new virtual addresses in new QEMU.  Devices
> -and their pinned memory pages will also be preserved in a future QEMU
> -release.
> +and their pinned memory pages are also preserved for VFIO and IOMMUFD.
>   
>   The user starts new QEMU on the same host as old QEMU, with command-
>   line arguments to create the same machine, plus the ``-incoming``
> @@ -322,6 +321,6 @@ Futures
>   
>   cpr-transfer mode is based on a capability to transfer open file
>   descriptors from old to new QEMU.  In the future, descriptors for
> -vfio, iommufd, vhost, and char devices could be transferred,
> +vhost, and char devices could be transferred,
>   preserving those devices and their kernel state without interruption,
>   even if they do not explicitly support live migration.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6c..e8a7d3b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -620,8 +620,10 @@
>   #
>   # @cpr-transfer: This mode allows the user to transfer a guest to a
>   #     new QEMU instance on the same host with minimal guest pause
> -#     time by preserving guest RAM in place.  Devices and their pinned
> -#     pages will also be preserved in a future QEMU release.
> +#     time by preserving guest RAM in place.
> +#
> +#     Devices and their pinned pages are also preserved for VFIO and
> +#     IOMMUFD. (since 10.1)
>   #
>   #     The user starts new QEMU on the same host as old QEMU, with
>   #     command-line arguments to create the same machine, plus the


