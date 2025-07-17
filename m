Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68798C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLtE-0006Xp-U2; Thu, 17 Jul 2025 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucLt4-0006TY-Vi
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucLt2-0000Ys-B6
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752748245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LJ5OgcTAvndnJ85hIJ+ynnjepSGwqzdmP3r6TxyKCcAkITle1bdx6cK2513QfadNGZn78F
 ORT6h1RD+SAqPPw8hDjPkiebGk2cioLVLTPfp4jgjaOBZCEPZ0c5cuuS5CG1/A+er/vmY5
 NwuqzF5W3EnwKqkCS4WvlQ3JfoV9EcM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-MUK4YWcqO9-rvy-6kazkLQ-1; Thu, 17 Jul 2025 06:30:44 -0400
X-MC-Unique: MUK4YWcqO9-rvy-6kazkLQ-1
X-Mimecast-MFC-AGG-ID: MUK4YWcqO9-rvy-6kazkLQ_1752748243
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae0a3511145so65740566b.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748243; x=1753353043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rTBa+tXZ5bDSNWUJ3RPA9dDqt5bfAchEtsZzfiEg2cjayo/JOlCNTsAZn1io0dJvWS
 XeDSX8DQw1p/gz/0ESWZS5nUtK8PsPgZbe5R5pdiKRnnMjfB+jvNFLW0ecEIvnrWISO7
 Fg/mX2sTetsyulnin/eLcfmxL7iEJD+8vigmpoLBomW9sDLcIzHoo6GPh03FoeZj+Z/N
 XhEEdjBvcpEdtXPhlj/ZR69rC+ELahwbfwniBFRpf8u3X0SDP3sCQpSz3zTNKvrmYdxQ
 gwNCRpwMzVjeXpJN86PBktFN5f3PjPtdms81jAQs5M9PMy4VR0crgB2uFyfWQyKMdNZk
 TyxQ==
X-Gm-Message-State: AOJu0Yz+kk+nyF2Ql5boud5VVaaxcqRntU6CqosDvWW5m5cqBfd2Tf+w
 Y8Az7CxaSWJeTn6+7S+w5zVHek2V3NiXjlV/FMglEObTW3PNPUWkV5SUEwSpDxkPJXrAwerH8OC
 TjwtJyUbnZqedjeJlSgCRKeSZXZgg4ZV8L7Bl5kCc7bayxfxJ0EBE7Z8B
X-Gm-Gg: ASbGnctsRYBtChfunZQqka8h4eJsZIO6pledwDRk0HNG+miOm6iSfDxK8ktT+tnQTbP
 /MA6QzBcJRg/MqYGduvUqFiPRXjtKCJA/7kGByxCV/bRDoU/JnSNz0Vh1YrYqB6dc1mE1UR0pkq
 RLhWa+bxuYPz1DDQFDaVCSNMlc12mlya/ivCBK9a7hrjeuxv2VHfoOUPd63uxDVZBx0noIdoBQH
 0oJHDYIJVII2HN+Q/HfrDdS+ftjZW9ZDR6vhl5EabAN0lsQTI2U/FpijzY2WS14D1EH8D8Ald9O
 IxyBy6ca1CYQWjZberYUrsq2JxBvYEAbeLjRGDoKvl4=
X-Received: by 2002:a17:906:7953:b0:ae6:c555:8dcf with SMTP id
 a640c23a62f3a-ae9c99c135amr624445666b.26.1752748243266; 
 Thu, 17 Jul 2025 03:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG1CX1HijCdgiD7wODtHEV52P6RybObawn2is3kxhg69Dj4dtCPxs0w0xULZ2XN0ZJyhLX/Q==
X-Received: by 2002:a17:906:7953:b0:ae6:c555:8dcf with SMTP id
 a640c23a62f3a-ae9c99c135amr624442666b.26.1752748242770; 
 Thu, 17 Jul 2025 03:30:42 -0700 (PDT)
Received: from [10.131.45.123] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7ee471asm1357084166b.54.2025.07.17.03.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:30:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH for v10.1] i386/cpu: Move x86_ext_save_areas[]
 initialization to .instance_init
Date: Thu, 17 Jul 2025 12:30:40 +0200
Message-ID: <20250717103040.329490-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717023933.2502109-1-zhao1.liu@intel.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


