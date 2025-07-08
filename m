Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF0BC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBN-00052q-R0; Tue, 08 Jul 2025 16:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDja-0000mP-2a
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDjU-0006DJ-3Z
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=L9q0gpXdPbg6eBCi/0mNIFkjCL7m/pypYuIcnyHvnFMMF3azwRWMsihLEoJB4NDHCOpBju
 WucQf6SW1ENUhmL7mUzy52IgsXDuX2/7g+Z2DbNhHRSevoXEpju3BB37I/AE1Nt7cYyE2b
 CfUICJxTByCT/JP10K0aIOhiQBBoAow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-1SNaaP9bOxCsILdT03J4bQ-1; Tue, 08 Jul 2025 13:11:26 -0400
X-MC-Unique: 1SNaaP9bOxCsILdT03J4bQ-1
X-Mimecast-MFC-AGG-ID: 1SNaaP9bOxCsILdT03J4bQ_1751994686
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1968226f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 10:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751994685; x=1752599485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=n7b7LK1L6ianwNx3+QwOQRxaWDQDhJNpLkV+ofJU6duUEuOLGZdRfXPVKNB0UTLAtQ
 +12ijBbaXjcJimy1vpXWKf/zT0540mcWyNOX3hcwu1DnIZXr5QGQMrHXJuzDYs5RT9kQ
 DX0+g1sohpJL3lda128x9YSlT5I5Gpwn8Qc7jobKl6orckVNAUfgFxnTdnGQjDHvNyhS
 FiFnHiyKLkclPHIXhdmUIFf7QjBQLgwn8Na2QrlbxJMBK8msVpHGcC0mlLBmrWOdygtA
 nx9x+zO9MpF49r3iucVIYqCjhy901YzK3oZzeGW5d7ZiU9nrEipUeclRZ7rTNljPY/x4
 8NWg==
X-Gm-Message-State: AOJu0YxdXGXs8x3L4HAhyXLYgNlSdA83ndf67uf1nhXFjacY0t0nsGTz
 MTZ3WFpQoYGnz9V34xmYgdJWaxFpMSnl8D1A4evyAL6kSdz+gooNT7PY0o0EFsdt7I8Fuu9r6NS
 SJEiBcWqLGfcj/ymkylBWOonlwPVyq+4fUbe5J2Kzft1LqC3xZ1dpFg3f
X-Gm-Gg: ASbGncunXaM9s/t9GSp/DDn09LwRyuPimIzWV09ZReY2ui/pXKCvSJHEoM62xy9uODl
 SsH/ITfhF5qfBG67YX/FyoJ4jEhTZvig7Y0/7d7nQ7yHznXFfcXMFGBhMLOQNV37V45Wok2nMTs
 nYsWtVrJq13HiMYBkA8RdpwYlYCdy1gn9Xy/q8evDnVbIGktEZePAAVbFJMawvI9Vyg1ovNjGW3
 yluFwQRhHYbZQDtqmGBLt2qizSqMWl7j8xIeow2ZaPqkdwrTkpee3w9rtgHhoHT8q56WyTUc8X9
 jmee/Fm+/AiQnPIaSbqYgUzRV3U=
X-Received: by 2002:a05:6000:26cb:b0:3a4:dd8e:e16b with SMTP id
 ffacd0b85a97d-3b5e2fec5f2mr237016f8f.20.1751994685340; 
 Tue, 08 Jul 2025 10:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5BlzEjmfXkCg2INScIyjHDS+TtAEYV0wOXIfXSRTeHRVcFUOvi3Au1j4Puf2zkrnm60cvEA==
X-Received: by 2002:a05:6000:26cb:b0:3a4:dd8e:e16b with SMTP id
 ffacd0b85a97d-3b5e2fec5f2mr236980f8f.20.1751994684896; 
 Tue, 08 Jul 2025 10:11:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97353sm13728753f8f.51.2025.07.08.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 10:11:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 00/16] Introduce support for IGVM files
Date: Tue,  8 Jul 2025 19:11:21 +0200
Message-ID: <20250708171121.145660-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Queued, thanks.

Paolo


