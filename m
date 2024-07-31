Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4929EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4st-0008Sy-1g; Wed, 31 Jul 2024 04:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZ4sr-0008Q2-1y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZ4so-0003BG-O7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722415229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TIZ6yR/fJa72L9JGLxe8WVIJuqve3vR0TgJazTSqTkQ=;
 b=BrV9vyz5Jg5QCmD9d5kbDSYvNUkP9wlhjr2t6Az4lW1M8NwP7yqjUpUNDQ0kAkLomK0fdu
 hBfGwmBTD9j55gZdKUDT3AUlKCNgLON15bCBJL0WfwI7IrunFlYFwG47uXpxhhMOpCYuOs
 tgksxfJbCFLL3RYpgZVmP+P3YOJxkY0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-IS27nGl2PnWdGc3yfE-KOg-1; Wed, 31 Jul 2024 04:40:26 -0400
X-MC-Unique: IS27nGl2PnWdGc3yfE-KOg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d2f42df2dso94187966b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415225; x=1723020025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIZ6yR/fJa72L9JGLxe8WVIJuqve3vR0TgJazTSqTkQ=;
 b=byvLf3szAFC8+qopvygFJMzibHTl27jL6tAUieqV345kcN4t/6LrlAaAgQmbkzZHVv
 4G+Wbo7vcex3UphSlPG6uQrEcmnzUmlf7RuuFNoG9OzZEbPKN6wtLgny7aI/0Wg2jyPS
 sjUVDxKzdVJ72bN+LxChbYDk0ngSXJeEDgaAFvCFVFqXFSg4Fww9qxAOW8inhs0NQqOB
 hDNgobp67u0CLhZoS4dUlsY6Vlz/7RFNOcjCNMZOmwk7DdLXsAxXMxVgjNsDEohIGU0m
 HD5cFZqP452wQfgxMhekmWf5aR97aUXLSekxhwquh3hFfF6gaRwR4PzqBxvEmMtWXBTx
 P9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTSkJ6fuznCmTCNQgeMY966dJbnEgMwdbQV5m+WhtRGumF+75JoMPt51pksPYYqKKlpGdHvt4QPKXamo+Xsb2sSpSi9uQ=
X-Gm-Message-State: AOJu0YyL1tilQfH7GCGssPzWemzCLC+gyChWEK7X+leBqhtdKyT5loDI
 vfrEZpu0dsKXSEZ51wiOYCynDJKa4IxyDQl7lygTp/oQccgr/mjCRhGM5cfHyEKCjHyxnodIJPq
 ND/c9qtyRakQkJb+PHGnBSc+H1EHlXUScPZD3tQi4JvG4ELHTMBMI
X-Received: by 2002:a17:907:7211:b0:a6f:e7a0:91cf with SMTP id
 a640c23a62f3a-a7d85a67704mr451893666b.24.1722415225357; 
 Wed, 31 Jul 2024 01:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGltPfG+2Lj79J+sEtv204kxLWKz7aFhP2Ljt0ehWnquNyRtxt5r1N8iExcK8k8ODRrLsHw==
X-Received: by 2002:a17:907:7211:b0:a6f:e7a0:91cf with SMTP id
 a640c23a62f3a-a7d85a67704mr451890266b.24.1722415224661; 
 Wed, 31 Jul 2024 01:40:24 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4148fsm748059166b.121.2024.07.31.01.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:40:23 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:40:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240731043951-mutt-send-email-mst@kernel.org>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5hyj71o.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 31, 2024 at 10:32:19AM +0200, Markus Armbruster wrote:
> Whether it would be worth your trouble and mine just to clean up
> "rombar" seems highly dubious, though.

Exactly.

-- 
MST


