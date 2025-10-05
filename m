Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 12:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5NlA-0001VL-Ib; Sun, 05 Oct 2025 08:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5Nl7-0001V9-9g
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 08:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5Nl2-0003Nh-Tf
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 08:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759666949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uH/GB8TaEG7yh514K08ygSmxD+EPnFiaGKf1haB0Uc=;
 b=PhfHkixPqJM/jThai8ZLlJon5FIHeyfkEFf46BAne7ZA/uhTNB1Mbpk3VELzjYM5bmC3L4
 F+GqYsqjRTq+4Yzc81ZirOVAbpJJpd0cN7azcPEM2Eoqtu8ZUzac3DNHMonnR5Yhrxgypr
 RVoTtfZQNWdmPKcLI9cjje2HbEiVW2Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-MwLo90nePTmmwjPNos0SdQ-1; Sun, 05 Oct 2025 08:22:27 -0400
X-MC-Unique: MwLo90nePTmmwjPNos0SdQ-1
X-Mimecast-MFC-AGG-ID: MwLo90nePTmmwjPNos0SdQ_1759666945
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so2786153f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 05:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759666945; x=1760271745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uH/GB8TaEG7yh514K08ygSmxD+EPnFiaGKf1haB0Uc=;
 b=FjP0ZXTXOOCtKpQuO4HZ5xTStNNU3c0JhSzFW/VBH+953EtnQweXbmtded49hJCUXu
 ed0F0qoA9K8PyOisqnHhrICMEb9jH+0OY7yQIK+65aZwSdK386WPe8vQoyK6HnBEEhlg
 2ugRrqKnczhcA8/tzbNmL848z1XIpdnsZLUfEs9TqZNem9t6YoUMGU+OpYOIWVCXNjOx
 7ffObXnirIbzk4q54XY8FOEzqVJpyROnzcaQ5npnJCE+W/OUiy8Q6kt2PpgkkDwXCGWO
 u+rl5lX717wW9ZM9H3mYPpYtVyvf2coDiuH+x8ZMZigMl5AFpkhd0Oo+MH8nTPS2ryE2
 Ngzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS04+pjSVSZqk9UPMgE55QvR4a5BLA15SkeMkf6CcxPZ0a1SoquMLU0WXFsDDasL5IbP+DZgPWrzq3@nongnu.org
X-Gm-Message-State: AOJu0YwL2eWqYKyOxK/xLJiP3IpQ8UXKcaYJB5hjUhRRPK9f4RvzIaYe
 Kx9ft9LhUWfiY4+6fSwROAsCwFCDwdHqsdwm90lTFin8l4B5CfGkpxgJMx2G0fzm3fjDi0PDp5B
 BnYBU87gD8+vQqgBZLxVeWWOEQM/5UiT8YhCAYpd6KqzjaU6js0M8Evit
X-Gm-Gg: ASbGncvdYGd2jk3b5jMrARiRM8OMXfzWu3wt3cBQDJTPUEzwjfEMv8eJpfTqJtuSpjc
 IfBPXNWgUP8v6v9OdiYelexqC1esmap6T6kIUVmS2ZkO6pGA0d5+7EIsd7Axpw1jSN/Fvl1hT+T
 PohH9gjhjENdwPGrUzaKTFbkBD5/q35fGFjL9iKQ59P1shffLgxKEpwKA/7JcxVZyQNyW/B2tps
 w5h62IZcX0xTHJa/rDAf7nwU2dQBeAqjNGhGAKSxkMtvZiAed/6Bx6/MBy/Ql6fQ8chW4NAKoQ8
 UblHApTCRxtFHC93xHHVjeRFsh81gHOXNFPzdj4=
X-Received: by 2002:a5d:5d13:0:b0:3f7:b7ac:f3aa with SMTP id
 ffacd0b85a97d-425671a9021mr5205857f8f.29.1759666945423; 
 Sun, 05 Oct 2025 05:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG1keuMZu665iO+IbiJSlMHjR2azOMigBt5fMWxeSQ4NRIhAMCkxk2rk3nz8YU5tZ4uo9RPQ==
X-Received: by 2002:a5d:5d13:0:b0:3f7:b7ac:f3aa with SMTP id
 ffacd0b85a97d-425671a9021mr5205842f8f.29.1759666944911; 
 Sun, 05 Oct 2025 05:22:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f017esm16660799f8f.47.2025.10.05.05.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 05:22:24 -0700 (PDT)
Date: Sun, 5 Oct 2025 08:22:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 17/17] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20251005082027-mutt-send-email-mst@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
 <5ea174638e33d23635332fa6d4ae9d751355f127.1758610789.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea174638e33d23635332fa6d4ae9d751355f127.1758610789.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 23, 2025 at 09:04:11AM +0200, Mauro Carvalho Chehab wrote:
> +        # UEFI N.17 Integer values
> +        g_pei.add_argument("-m", "--multiple-error", nargs="+",
> +                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")


While I'm merging this as is, I ask that you please address these
unreasonably long lines in this patch by a patch on top please.

-- 
MST


