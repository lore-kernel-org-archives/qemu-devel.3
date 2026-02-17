Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB3AE909C0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsMbm-0006yU-TW; Tue, 17 Feb 2026 10:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vsMbj-0006xp-MH
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vsMbg-0006vU-2M
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771340596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6jU4/Ha+8bPS6MIRH3FxqQXDetxFjQGz7q3hXF9asg=;
 b=BTO0nfVGSpUqEPvgnfuKXmR/rIWLAkNfW3jZl9fLjfk1/rkeS537wI1OO64NfyKz+N5uRh
 yre35TX/4jQZlaDCi5Y1FY+IemKykH99uhI4Z23Vm9MpGjroo9VaX4fwDQatMwwVUlSTXA
 C+HS8nq2/8Y7MawIRTrrnrDiHbhT+VU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-cKvDR6I4Mbut1jKZQQFucw-1; Tue, 17 Feb 2026 10:03:14 -0500
X-MC-Unique: cKvDR6I4Mbut1jKZQQFucw-1
X-Mimecast-MFC-AGG-ID: cKvDR6I4Mbut1jKZQQFucw_1771340593
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4362456500eso4213154f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771340593; x=1771945393; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U6jU4/Ha+8bPS6MIRH3FxqQXDetxFjQGz7q3hXF9asg=;
 b=l6+ZJIEkQ3Ca4q6hwzZoo/2CTPPUyly+NT53YdrTjxILhjI4EZxI08Uu3fYCOzOMj/
 AdgTmeMbXlipxLIEoXzBIKtwHYhgw0Ty3OO3bFGK2PXzEylGr3pQkGxxTsXqQaMpxFMf
 GH7z8eakDbpAdf1bc0hYFKcZMswxhZPolar0CaXVO8o7gbZzPBBezKSvMabhvO1t3q/X
 yo0UdaER1cgdW2NEIJOPwlIaRQJeQu69atH9XDlg8mU7m6jAm+R/rL2+qQMJo6cuoJsa
 aGFOatF0ViKRxKrafIpSl3+hfcHpx8iE5BL0QhfeWa0/A7VcpF6UN36zqi5DZhbr4pm/
 0GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340593; x=1771945393;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6jU4/Ha+8bPS6MIRH3FxqQXDetxFjQGz7q3hXF9asg=;
 b=uSze6XGd8lScTK5xdKC1NWUtobSObK5HtbKDpd1I8dQCk0eAvoWGpIH6b7Xney988B
 lfE4/5jzcW6Qb5vGHBsYASye42SXTxljCUmSdYbLC8jwI2+LnLVAwxenM9q27MykJ9wW
 eqykxWQvFCTJY5EptrKtvZyTQ6lPL/UTLc+0r24+AqucDDU2se2eNxtR4u04C0OOnPP0
 D8pHepwzmC7dPUTieooy42X9TGKDtQGSIsrgx+uYrUAmyioRlvX9W723xQ07vfqZ+LzW
 QHpmtbU9hTZZqU6qDHaAjNKuUbms1W6XrSs4yVMOagWaezX/9YpmKdbb/kkUnMtzIYVt
 SVMQ==
X-Gm-Message-State: AOJu0YzD0JRKZxqPiRYwWnibMjX68GjcaBdoXSLkZ6QI8nerJWHzNh54
 aiBxAGpKAJKibCirknloK1DMWlOjH52Qc/6QEQa3iI6TFjyV5L1YB6Dza9AmRg012gS1asIXdV3
 u7+eTbWjtUwIWdoSMOGX3a1WU5g6Qrq9r4JnNWad2thqEQdnpJR2l5mJv
X-Gm-Gg: AZuq6aKKhqnak/u8fseR53gGyaT6qGjTn30Xq9mydGX0JL6bfu4PiSG2tU1qoXcXBdg
 2DFhBvETJWyHQNDDGjl4ldHX4pAWLWEOZ354+L6+ej5z1YkgGOHfVTV9MSlIyKG871f4vvyzyQM
 g0p+2L/OYf1VPUXVACLR/U/p5mazxKFg1Gu3quU5P6Fq5/NB4ss0sqMTW11wEPC1S0HcUgA05KC
 fujmPRHsbZglYwrUm4gk57pMgevXX4zHoW6lLv0C/J88IuAB0izcbZR+f3rql0JMEx9YElAbj/T
 XZdJbTiIEX5+/PgIZt4nj3SozV9LkxW7Az8aiFXNLgujVqe5kvDK+Uca1ZB6jNPmvUKIztSGmYI
 JZfEEPI/lJmYn5233QM/scVFUr3N3JsvwUVe/ULYjbLLLDg==
X-Received: by 2002:a05:6000:1446:b0:437:6c6b:1f9d with SMTP id
 ffacd0b85a97d-43797955c6amr25962465f8f.61.1771340592983; 
 Tue, 17 Feb 2026 07:03:12 -0800 (PST)
X-Received: by 2002:a05:6000:1446:b0:437:6c6b:1f9d with SMTP id
 ffacd0b85a97d-43797955c6amr25962399f8f.61.1771340592403; 
 Tue, 17 Feb 2026 07:03:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac7csm31663091f8f.7.2026.02.17.07.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:03:11 -0800 (PST)
Date: Tue, 17 Feb 2026 10:03:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v4 0/3] vhost-user-bridge housekeeping and test
Message-ID: <20260217100300-mutt-send-email-mst@kernel.org>
References: <20260129133049.119829-1-yodel.eldar@yodel.dev>
 <cba38de0-38c0-4d99-9d50-a028fa6510e0@yodel.dev>
 <749d684e-d4a4-43ea-af55-bd901ac7b97f@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <749d684e-d4a4-43ea-af55-bd901ac7b97f@yodel.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 17, 2026 at 08:56:12AM -0600, Yodel Eldar wrote:
> Hi,
> 
> On 09/02/2026 10:08, Yodel Eldar wrote:
> > Hi,
> > 
> > On 29/01/2026 07:30, Yodel Eldar wrote:
> 
> ...skipping...
> 
> > > Changes since v3:
> > > --------------------
> > > - Fix is_readable_executable_file() check of vubr for skipping test
> > > 
> > > Link to v3:
> > > -----------
> > > https://lore.kernel.org/qemu-devel/20260120215021.30711-1-
> > > yodel.eldar@yodel.dev/
> 
> ...skipping...
> 
> > > 
> > > Changes since RFCv2:
> > > --------------------
> > > - Promoted to PATCH
> > > - Collect R-b's (thanks to Marc-André and Thomas)
> > > - Add test to .../x86_64/meson.build thorough suite (Marc-André)
> > > - Add encoding= args to open() (Thomas)
> > > - Add pylint disable=unbalanced-tuple-unpacking on find_free_ports()
> > > - Minor commit message rewording
> > > 
> > > Changes since RFCv1:
> > > --------------------
> > > - Remove external host dependency (Marc-André)
> > > - Use user netdev tftp feature (Thomas)
> > > - Use check_http_download (Thomas)
> > > - Remove wget
> > > - Inherit from LinuxKernelTest instead of QemuSystemTest
> > > - Use hardcoded UUIDs in files on the guest and host for data transfer
> > > - Use a Popen context manager to terminate and wait on vubr
> > > - Add test to MAINTAINERS under the vhost section (Michael)
> > > - New patch to move from tests/ to contrib/vhost-user-bridge/ and add
> > >    docs section
> > > - New patch to add RX debug logging in vhost-user-bridge.c
> > > 
> > > Links
> > > -----
> > > RFCv2:
> > > https://lore.kernel.org/qemu-devel/20260112230127.99125-1-
> > > yodel.eldar@yodel.dev/
> > > RFCv1:
> > > https://lore.kernel.org/qemu-devel/20251230002604.113632-1-
> > > yodel.eldar@yodel.dev/
> > > 
> > > Yodel Eldar (3):
> > >    tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
> > >    tests/functional/x86_64: Add vhost-user-bridge test
> > >    contrib/vhost-user-bridge: Add UDP receive hexdump
> > > 
> > >   MAINTAINERS                                   |   1 +
> > >   contrib/vhost-user-bridge/meson.build         |   4 +
> > >   .../vhost-user-bridge}/vhost-user-bridge.c    |   7 +
> > >   .../devices/virtio/vhost-user-contrib.rst     |  39 +++++
> > >   meson.build                                   |   1 +
> > >   tests/functional/x86_64/meson.build           |   1 +
> > >   .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
> > >   tests/meson.build                             |   6 -
> > >   8 files changed, 200 insertions(+), 6 deletions(-)
> > >   create mode 100644 contrib/vhost-user-bridge/meson.build
> > >   rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
> > >   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
> > > 
> > 
> > Ping?
> > 
> > Note: All patches have been reviewed.
> > 
> > Link to v4:
> > https://lore.kernel.org/qemu-devel/20260129133049.119829-1-
> > yodel.eldar@yodel.dev/
> > 
> 
> Ping?
> 
> > Thanks,
> > Yodel
> > 

i will queue this shortly.


