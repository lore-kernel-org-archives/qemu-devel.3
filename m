Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FB6C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoH5-0002h6-B9; Tue, 30 Jul 2024 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoH3-0002er-Iv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoH2-00024l-7Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722351383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Jec0lEoYdwpG/Mv6kIOTBLFnevgaurGC+XZMfh6Fdb7VzvW3zQYTJr2C6BsrgzWBQl3jh4
 Okv+TTS52pyLQ1llvTz1eirPYe42F5qEC1A4P2aVTB6xjihLDEB/sXmTtQRk1dxhjCIfkh
 nP19md+Q6ksFqWX6nf+9cwvkLoTk5kc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-21GN6EaMP6O55AH6NMCBfg-1; Tue, 30 Jul 2024 10:56:21 -0400
X-MC-Unique: 21GN6EaMP6O55AH6NMCBfg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so4891496a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 07:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722351380; x=1722956180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=u3gkFPvg2IjLs85ptfpIIFWGKoOv9jK0HhfwlgFnqQlWcXCT3unQi3jV07z21L8jf+
 WVXkA9EzraRwbNzxreep0PBwXmgMsq118fWjfT91dsB3NtKF6jmHlOtg7T40Boj67NCr
 +shmFsllvydwYWOjiDydsvex7VrpBjFE0Y0+mQgpttBHzJ8Pg4510NqwWy/daglpgBUJ
 M2z8g5c9I1YXpaxdjeRemuNSxKlwDaNPHoewJQoZWAVSD2hQzXzEYsV7hXDpLTOGs8/V
 uYyiawuHhBQUc0fKDSjTxzDMMVl2dD50+Oc5bH5HeYt3c8QPA3Tb8dyTb0quUk0rmP5p
 3X3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwqkJlX9NWe+mYxTPXH9Fp6vAZg86I8EVl7jmnKU3ugIUzNYwMz3WXNrUebToST+9a2Ilh7xqlVLa57RwNBzqNRkf5Clk=
X-Gm-Message-State: AOJu0YzVwj39X8sQ1MkyI/booPxooACQjypDMhx7dILy0c8NLZFKB20E
 v+nxMvkMKsZWoz69Fv5Zw7iitdArVNqNlzIEIfQ5qfWOJ0accQ7lo7JQm3uJDQob4pwAgUbd96O
 EYzoo2K9y8QW+rgWeeZVwbjnSU5OuajW7uebbeU0MK18foX0/a2Ao
X-Received: by 2002:a50:bb45:0:b0:5a2:597:748e with SMTP id
 4fb4d7f45d1cf-5b0211908bcmr7058328a12.2.1722351380207; 
 Tue, 30 Jul 2024 07:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzkn0CxyMA7XirdZLScOn8lScLNigW5ihTEJ84cC/RZHY/Rsy5JfAFWsr9PCl8delBc7icA==
X-Received: by 2002:a50:bb45:0:b0:5a2:597:748e with SMTP id
 4fb4d7f45d1cf-5b0211908bcmr7058307a12.2.1722351379849; 
 Tue, 30 Jul 2024 07:56:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac657836f9sm7188729a12.90.2024.07.30.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:56:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] target/i386: Change unavail from u32 to u64
Date: Tue, 30 Jul 2024 16:56:12 +0200
Message-ID: <20240730145612.62437-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730082927.250180-1-xiong.y.zhang@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


