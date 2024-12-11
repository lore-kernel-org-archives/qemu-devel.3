Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F028E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUVu-0004hT-5S; Wed, 11 Dec 2024 16:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUVs-0004gx-6U
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUVq-00073d-ED
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733953492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KPfPdW0LriAUD7B0UKBodC/5Faw4lXbsh6sijLweGc=;
 b=gsxwY/vAwuzAkHlqNBGkVrOwNzJtSoNKZlC+bIsLGWzE7ln859rjDQTSZuDgTmB43q7OVY
 yqrcqUFsBOLmImQybnVys11dCWF3ecAU9m3xZZU3Cy5bRM6nVZe/AAI3FKFIeiuIZcvnC6
 +xQ03y2VAZpwM1qWgyLmujuf/M9Mq/c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-7xiod5qDMCqhm_7Hztcbjg-1; Wed, 11 Dec 2024 16:44:47 -0500
X-MC-Unique: 7xiod5qDMCqhm_7Hztcbjg-1
X-Mimecast-MFC-AGG-ID: 7xiod5qDMCqhm_7Hztcbjg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46796f4d7c8so2549181cf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 13:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953487; x=1734558287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KPfPdW0LriAUD7B0UKBodC/5Faw4lXbsh6sijLweGc=;
 b=CC4VNX2ueNT6Q48mjW2JjOnzGFHEB5VHhIPYuE1QiToLlQ1ECGZ0Ye4y4fyr8NPhox
 39CaAdBnv7HoPSzT6XqjVIOu+kzqWiwEeWB/3yPjNslswqpw9GiHo2H6Puubn9J6Lhsh
 6jyiZ9aZ5a6StsQLj8zahx+5fbB4Mrt8Hth6+0Z4wUIIh2yOuP8ZhTNhp4zcI7Kqkmrj
 9JrbP2TQzDvXePmfbH3Vmcdg/5315Ra2AzYVVl74q0v7bfYoJnJfOh6WOCDMtpeV2/dz
 ppyYv+gcm1f+23IsNIwbCBFFbBxuUlHNC2NkNGjCD89BwzL1pfq7GaTpGAHl9UFEjg20
 XnTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtm7CTAZe7Xh0YJef1Z7CXCI4bQejdLOPEB4d7yKsMoi020pQ4f4UmNQwlGhXeZjlIr006EMqFFXGQ@nongnu.org
X-Gm-Message-State: AOJu0Yz/My4uwl4XTB4nHfnJwiO4Z5q/rslGC1D0KkMDrdNW0lEK51ff
 3f3yMxfqgyThl+GrMSatXR8eOfROtBwDrJNFeGr/EBq1ewkSUJRfM2fS3SOuTHrUOuTEbIjbF81
 29ezVchxj4qKnnTBUUg4PzYtciHf2c+2KVchz5vry42J+taj7LYd0
X-Gm-Gg: ASbGncv0bYExndqATVSV/nQc2y22GaQSnYH7nEtNvGZ2OxnG/j/34ZMR7yGeYdQaUP7
 Q9DwWKX/ez5xdtDX3HlsdNUwRdiszR5eQInP71PIdlI6pMEKEbdT0vqqsF9Pxd8+yRBQw8W813Y
 zryNzh8DpuoRx8tgy+15k7SxEjGSDyEZ+crowpkFdHhn29RfafU0vKpNJBFOfu2a8dW30XFBcGl
 xiIak/D0X1hQP26oxMem13SLbKbNOb0vMZcx9AssaszSg19mQ55nSsWFLnXjRmRH1MTbpAzeUzO
 8OdOUUdhMWIJjqg=
X-Received: by 2002:a05:622a:1b92:b0:461:2150:d59c with SMTP id
 d75a77b69052e-46796157244mr17043181cf.9.1733953486889; 
 Wed, 11 Dec 2024 13:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdXo5KhuqRlaGG2DoP0SjOT/KJ7Eo53xVVY1hC12SSGyxYjVhKCIwyHuAabradcsOk2gmDzA==
X-Received: by 2002:a05:622a:1b92:b0:461:2150:d59c with SMTP id
 d75a77b69052e-46796157244mr17042911cf.9.1733953486597; 
 Wed, 11 Dec 2024 13:44:46 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm46670661cf.70.2024.12.11.13.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 13:44:45 -0800 (PST)
Date: Wed, 11 Dec 2024 16:44:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] os: add an ability to lock memory on_fault
Message-ID: <Z1oHyye_QXZiGYFs@x1n>
References: <20241211000447.1310181-1-d-tatianin@yandex-team.ru>
 <20241211000447.1310181-2-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211000447.1310181-2-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Dec 11, 2024 at 03:04:46AM +0300, Daniil Tatianin wrote:
> This will be used in the following commits to make it possible to only
> lock memory on fault instead of right away.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


