Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C9CC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gm4-0007TX-St; Tue, 29 Apr 2025 04:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9gly-0007PV-S7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9glw-0001IX-Pz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745917017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ynp6fQxKz5eSCdVhDapzsCrbA3gzu3PRDxoqBjuDbTurPdsJ5sVYBZy1ss9HgcfuA9k0bx
 /rt+CRnDqnZNhUMqXDwCF3XMGqoSMUu5pxRLZHqIRVaP9oOLoWz2lTyxsXgtHdHKMhcNnT
 Hni8VnCbS8nD1fE9/7tbpJbnvyjRzng=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-KGp44BRFMWyS5fyh1EC5yw-1; Tue, 29 Apr 2025 04:56:56 -0400
X-MC-Unique: KGp44BRFMWyS5fyh1EC5yw-1
X-Mimecast-MFC-AGG-ID: KGp44BRFMWyS5fyh1EC5yw_1745917015
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso490707266b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 01:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745917014; x=1746521814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=vD0nMaspLRWDSndsuLJAkzIZY7UAw6LeqpoO9DTqcJy3VMVHENCcKVj6OpI2u3Bybs
 CPg2gEiJS1shTz1HwR7ke6+6IBkQpXYfrP9k9n0bVd23yc/F5SLz/v5gkkBJwc0cZRoN
 SftC0aROfTlBoPQf4YqluUEQ3Y8KU838xN4oW69uUGUpmpq8jPm5gFDvFrvvSYEww9kV
 sp13WxHW7AUBYXEUv1vyWvVi/oMCjCka8j0e2UajoquEQ9l3I0Lj1uNQ2knhVnV4kA1R
 KZ0Hx1nY6i+/4QlIRFKXF0gyq8rM74GLb4g2mVFzMfuCK54iinq/kVcGyX1qoPVy7wXA
 ReEw==
X-Gm-Message-State: AOJu0YyKCmu8++o4ErjXzGHHt+Oc49dmoJP5b6G1WCDdU6LAPQeoL2Y8
 Mkh1IxwTYZ/9Ai4PPV2sEi+ebt4YS8IeiyOKWLYW5I5/UaiQ4KdQt9nqk5zmgEUL9LzUzkyxrGL
 qnkSMvyPauqE1AFA5dc+ilbKRgdewUpkB7qeMwDS+iBs3MdIoBl1qB3TkTjH/
X-Gm-Gg: ASbGnctStFDLpUqMBSob97jHOu35jXCHboufMIIvumXnqI4A0yhUVWL39Ujb3s1lHCS
 KKY8nFZByLhzvuhAIP/DlxdgomuqAeMAtoC+t4ORLc3S32Iy6pP42pdK9UL6IXg2yaEn5daQVY9
 BcAd5SWVqqdaRkt7usHbWC9ot2epmI4X6mYEVlB2P52mV+oimFr0a6G4ylBscui46v2zmkPBDj4
 mQMWO2F99/5JsCcwkqYVrddtVm0nOCXNo7qpW7Ls4nYPGRfxvblT9MdQgdy2aZAEk3BYv8vaAk3
 y8Z9pdzpcXKhkvOCuMv8MZmnSHIB3/aGfKM2br9Qybw1Gc8=
X-Received: by 2002:a17:906:5784:b0:ace:d3f0:e51d with SMTP id
 a640c23a62f3a-aced3f0eb51mr12872666b.54.1745917014441; 
 Tue, 29 Apr 2025 01:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj5My33nFgGp22qFKTnrx6o58cq0JH7UE5eqQ5g/XUnXKvX27n1Yp2ybksJ0Qazo7DrcO2HA==
X-Received: by 2002:a17:906:5784:b0:ace:d3f0:e51d with SMTP id
 a640c23a62f3a-aced3f0eb51mr12871666b.54.1745917014110; 
 Tue, 29 Apr 2025 01:56:54 -0700 (PDT)
Received: from [192.168.173.123] (93-44-9-144.ip94.fastwebnet.it.
 [93.44.9.144]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ed726f6sm740571966b.158.2025.04.29.01.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 01:56:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH] target/i386/hvf: fix a compilation error
Date: Tue, 29 Apr 2025 10:56:51 +0200
Message-ID: <20250429085651.13725-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aBBws1ikCDfyC0RI@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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


