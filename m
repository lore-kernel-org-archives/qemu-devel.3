Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E633CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZlsP-0007M8-Qi; Wed, 17 Jun 2026 04:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZlsH-0007L8-Pt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZlsF-0002kj-F0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781685828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=C+1LsJ7cvzUFmsrOjeIgksrjWyG72kz+lBb6Nwp2ZGEuti3rUA7fOoOmosA7HycYM7JLXq
 yjNgwSStQ2TSntb+x8jZDvrBwNulvqA3Bil/mwuxM13ZyDxvKQd8+f/rhmK6/VnwxAUSZk
 mgizRrtnMSh6KPqATMHQFnJy0rFRbRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-7t9tdGG9M8GWj6GwgvWxAw-1; Wed, 17 Jun 2026 04:43:47 -0400
X-MC-Unique: 7t9tdGG9M8GWj6GwgvWxAw-1
X-Mimecast-MFC-AGG-ID: 7t9tdGG9M8GWj6GwgvWxAw_1781685826
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso34674905e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781685826; x=1782290626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=mc3NEfHCRbQiYQ4b9CJn6pzg402Pks6KJvXvegz419zCbDphIDGIigm+6loAZudOdm
 9ictvHbv/v+v52PojwU/wGOgqsYkI4l1Mk2j0IU9g+nkzKAig31IKMY6KQ5bE+MLbUdV
 d2OiXCQQcKj6WPnm3WOR2AfRUZVcMxy5N9YdxsxYcjKGnQva39gzcWU3nVc7H8OJ5NUd
 exQZdxlFLi+d5NNAC3zccbLmv6rmKZSX8XP7pC5FStQKfbZNP5+uf33nASD6ujJTNOnt
 3s1wKiSC62qdBZNZAtnbVCVwVo15DI8dW1Ze2cTWUzXXfZwdD0lP1SLqo9sV68QDwbg9
 zyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781685826; x=1782290626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=oHK1DJ3TBZaVihe5tGgO29x5I+BLtaJ+zWs75hjGuYsKaCO7nXcl+YSdV9sSLbzdy9
 bbZ6nRHAmDKnwV6Y3FZnBHqcZpa8bCF2L+3Dx/2m8NHyyhAHol9FVG8+fy7BWMpUyWwz
 nQve1NSM0bvC/PcKKPJJFf6fBu4mqCMw0BbAkhMtWQTVZGeQPcNfzBOFY0ScOWpqmq7E
 frlFr/xFjkR0Dzh+JtQ/Xd1mFdxyNXfkHeWffxtQ1q6M2Vwl8JeZETtsMad46y9fLkIn
 smd3pUP1VRASQZEgUaCSNBCF8kVwYnRWO7qm7WaCAC6Gm4DWqh7nhJPlPlDo/PWXWqzK
 b6ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sYGnInCtV7qpXEop9M24ZRwTLcaUB9SP5/zRVbXDMYOVNVpVluq8p43GW3JOMRdQ0GGzjcJpDvMUF@nongnu.org
X-Gm-Message-State: AOJu0YwfveGSs+XboOc9m4UaMyx5LTqLg3jfKXQZjEy+nLHxXfcjUvDm
 xG4tzeIxAFGMSwKfpVEUNaHU63B91gyec3XhaZVn9IqVqPnglNtahnz8jN2i2zm0WFkQauOQTW5
 CEMF2hJX7St4fWUHC+KEHJIgojgoBeuXLvgy3IRDt9gbrjkUlGFXQwyTz
X-Gm-Gg: Acq92OG5vMDdU2Q6ncFDQQU3qONNLvZecjM3O41FsAm5rjjS5TcwTfI0NqNTWw97V6c
 rJbvLQKgwKez1HEGoPnB7DdET3XGkwXwMHrLMSn0AfqsGmkSpdrHL2VeXGLdljugJL3ZzbjTvCu
 e65DPpyeEghId8e4q/BtbhVlbdiWGnW4Ny0rwG94771twjfm6d1serY1TRLT4WytqMPDDs2aw38
 +ER/1r9BXq2bPHp9nLH/+MPV+KncHresEZxpfuSfp556qoPNmmc76xpLm5pcAMZbqIp8LrpPAvC
 anIFnGytqNaTCeWiKiOdOI3Vz+XvUuPRpebHXk34g/ez/vi3tE9CMbvItvyXpXQzbILsv+O5eEC
 90QuQyExzbUkpkinxID/MCzV6Tb/X9HGGRIBzFmxVTYg80uq8DzsrYobE+gIoq9P/XpclHXAIu0
 QhP//MWdi3qcmdbhuu
X-Received: by 2002:a05:600c:19d3:b0:490:b99c:9337 with SMTP id
 5b1f17b1804b1-492333a987dmr51846035e9.10.1781685825691; 
 Wed, 17 Jun 2026 01:43:45 -0700 (PDT)
X-Received: by 2002:a05:600c:19d3:b0:490:b99c:9337 with SMTP id
 5b1f17b1804b1-492333a987dmr51845525e9.10.1781685825301; 
 Wed, 17 Jun 2026 01:43:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm252255785e9.14.2026.06.17.01.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:43:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Damien Zammit <damien@zamaudio.com>
Cc: bug-hurd@gnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 manolodemedici@gmail.com, pbonzini@redhat.com, stefanb@linux.ibm.com,
 peter.maydell@linaro.org, kwolf@redhat.com, berrange@redhat.com,
 eblake@redhat.com, bugaevc@gmail.com
Subject: Re: [PATCH v5 0/5 qemu] GNU/Hurd support
Date: Wed, 17 Jun 2026 10:43:42 +0200
Message-ID: <20260617084342.315380-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260208055858.2166524-1-damien@zamaudio.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


