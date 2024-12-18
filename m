Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD8DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0sg-00036k-Kz; Wed, 18 Dec 2024 15:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0sf-00036b-6b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0sd-0007S3-RL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734554569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dYdGs+fnALSL7gPsye24vzvLDfxsH70BxSCJGywpt4=;
 b=XZ7SpVmic0HaWUIFdsZIL8qqH1BmR3amNckK95q1Jxj2qCKJmr7CVOl10wms4jB6kWatBT
 mURgRQtm28qwn8AtPxg926VyRRraCkT4nn/Cd0wBhkdBUo4+syQ9X5fUk+/4dkU07D1m9V
 sgf6OI2n7VzKtjBS9CHi6UFo40VtCh8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-DjE2OmAKNHmBVfMAlkM-Sg-1; Wed, 18 Dec 2024 15:42:47 -0500
X-MC-Unique: DjE2OmAKNHmBVfMAlkM-Sg-1
X-Mimecast-MFC-AGG-ID: DjE2OmAKNHmBVfMAlkM-Sg
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46792701b64so149155331cf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734554567; x=1735159367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dYdGs+fnALSL7gPsye24vzvLDfxsH70BxSCJGywpt4=;
 b=iJxF5yc9p1MISc8uvYgeNlt2S5bthvJvTSY4VQbp6xPyLOge67lYya1HggVSt3J91Y
 witk9awhkwZu+hNhS45mK6gVDxDSXoju+hX9l7ye43m4vcuo0446cjEOhhTwN36xNKBc
 qRJgeiC0YcpqyFkO3ObOh/9CT4FoiReB8Sz06qQQ2++FZ6qqwxjN8fL9L/syW6iAJYS5
 k2f8JGU3Efxdu2MOuKi/OF9Razih99xBisBIYzuOZ8NaGL1msAw8Bjvj1W2FDdaVmJWp
 UcMeo8ewoRPYB4JjcWtB8rGXBGPpI6c2q+486zVQpmsJFDIJ8XH6HwH54lKORwSHXh6t
 Ks7A==
X-Gm-Message-State: AOJu0Yz3/LgKg+7i+tbipFL9A+lfTdWE53G9zd3KfP6WaScQUVvybQR1
 CPO5CIvrj6Mq33eWKLhCttv+N3YyOwSbhGP1hbwkV+K53+5pgi2zATBJpDoiaMJq4QHHDR6lHRq
 2Z3K3MAkv0yNkJDnAuDo3nBdu4lhKrP2hPZmaJR69wpZZBoqnrM20
X-Gm-Gg: ASbGncvLQhPBRvX6Fl34NtJgiVvkf0G2838J6qWj1ofY4SELKJ6Yul11cW+epcaknwK
 eEUKihjOHTA9MPaXpmfW1Sv6c0o+4xDuDs7ejdNxtdVIz8lffuwNrdsWubXHI/oK1YUxP0t8KvB
 KHcNizVY84Bhv+p65ZE/MSIazwaorc1IqbJtNCKVE+41mWr4Z0o6I4yMhvrggDomdZF+DoKKLJJ
 UdrYs5QmEhTfq3Qx14HVzjfQt5G3WWKUkSYjeBro0K2fcm+3ydmxLt8CrKRmeMFdNLp6Ay0uYrv
 B/1HVBBXHJPGyWC2cg==
X-Received: by 2002:a05:622a:44e:b0:467:800f:f475 with SMTP id
 d75a77b69052e-46908df7c7emr66756871cf.19.1734554567361; 
 Wed, 18 Dec 2024 12:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8OiqaESgF1G4k6LYShv22cSx0Oknkqoj2q4ipmzQtXLp7EbPd7UN4YE/be9mAncX39T6g8A==
X-Received: by 2002:a05:622a:44e:b0:467:800f:f475 with SMTP id
 d75a77b69052e-46908df7c7emr66756681cf.19.1734554567107; 
 Wed, 18 Dec 2024 12:42:47 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cd9b9asm54818471cf.51.2024.12.18.12.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 12:42:46 -0800 (PST)
Date: Wed, 18 Dec 2024 15:42:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] tests/qtest/migration: Stop checking
 __NR_userfaultfd
Message-ID: <Z2Mzw3LFLAUi_eEE@x1n>
References: <20241218192223.10551-1-farosas@suse.de>
 <20241218192223.10551-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218192223.10551-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 04:22:23PM -0300, Fabiano Rosas wrote:
> We don't need to check for __NR_userfaultfd in the tests anymore, the
> syscall has been present in Linux for a long time now.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


