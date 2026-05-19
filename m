Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF27CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRKP-0004ld-Iw; Tue, 19 May 2026 16:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRKO-0004lE-MK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRKN-0004qs-45
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c83/c3gDxSXB3EWpgfFwKjt7wS7O0C4q28gEfUCSNfw=;
 b=MjZHuYA3elDUi8dmIZsNCTCqqqp83wyiOr0+LMO+pzPCoDEe0kK+/ax/3oMrfTHzB8VVKU
 uTNGuHmUDAbMJxg8K35VQhf/Rim1wdDmqIS85xMKifbZvS6ZoifxJlDZgPA+BkL6hAiPdC
 SKonm5rwUS+heCwUxYI01FndU09yc+0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-dRO8V0MzMbC7bQv8ZGxESg-1; Tue, 19 May 2026 16:46:08 -0400
X-MC-Unique: dRO8V0MzMbC7bQv8ZGxESg-1
X-Mimecast-MFC-AGG-ID: dRO8V0MzMbC7bQv8ZGxESg_1779223568
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b46c014a26so128006066d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779223567; x=1779828367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c83/c3gDxSXB3EWpgfFwKjt7wS7O0C4q28gEfUCSNfw=;
 b=QIiQ/NGEWkKTp4MryanuC2BqJBdz0X75pGJ7rpfC9aa/EJvn03oe6t65rMBRg/zy8T
 /ktc2TIob6FDMaSIUd9IY+rFbSB9QEA6GGHH1UXKD/LPxQ1lYV+dlBE7zMAmYQsmZf/5
 g9Ws7tO+LStF6dapul9WeUNDFOkPzv0mICUOmqox+nLdpkvOQqRkGmFl/Va8xawIZdUT
 nuTgi/+U1kMX8OHp7QwrYplNKXQ3nEnDXbe8wJoVrKJlgvPQpqX+NyBSSYqmE2IDQPwP
 B9aFF0ILkbkg9sk3n6ixtGQcksAbIX4zNqGz8zUqstZvA/dJRa0wqRZ68dod3jnLF3cc
 /x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223567; x=1779828367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c83/c3gDxSXB3EWpgfFwKjt7wS7O0C4q28gEfUCSNfw=;
 b=AcAoKn395pFz4N3CLyXdhcKmOUHIDXfQrSq/+TOyemSyUbnPTtmVAFElcYGYmYrqs/
 2R66eIuNAjouEQv1PXVal4hJD5SVdw1/7DN8RBiJ41nak70UXVu3y7c4ZE90K6dngBRe
 aM/6NEMzOlhMJdQFXh2k49MAY4YD7M/cuCeogB6n92KO4I7Y71v5SYpC/MZIa2cQcyat
 yQ4aul1nejiWYD/ieHrCrohFtZoW7jh+7mHUUlyUb/rKlkXYd+vHFUl6B83KAmvEEi5b
 WF4Qqm+gU7Dn/g/akXYdI7ZasbyBdXl3B19Extg77DlzgS/V1Pjd+uvEj7vOt7ivJEhW
 tUKA==
X-Gm-Message-State: AOJu0YyVZ2lkqu7f/i+yZoUgwi2QsMa/efd7qhSDKAU/oiGRLtUKIZ9G
 MpRwrEWO/NqVWb3OMbVdaK0ye/GC3gB+Zo4ORc11GtLPzgMP4yQzFMDFb08H8DcilfC9eaw72ac
 jwU+FajLy6FWZBVMCV/ZJfdhz0BE5wr0Oam6ZQEIk171w6toIeGjvCdl5
X-Gm-Gg: Acq92OFRaTyyW3g+n0Qn1zgOGywT+olw/xjouAdoGofsBGiDlAmeabgYW/ruRAwD/ig
 +5ooeQrYlT/LwQS5WXG9OS8nVlZZWRTl3CyyhfBsQHzXV8lsOEk9P0ZpLRBTu3C17uko9akWlqZ
 vMeW+WboDlz0gtM9CtPl2wQSHy/w8kenGmms1uHXmukFb1gu+mGcGhAEyktd0g/e/tT9gIpSMOZ
 XL+8L0I7RlO3AXkSfkZk5a8vuhMqKUkImZ2AqNON5Zg4qvlrRV/c1GVIfGcMWIJYhtSoHF0gEBK
 YHvOsCopDXZr/mi2u9jlS+H/rTGeQpNVPrk/taq13B5LlymG28jb2sddh25LhhRxe5XHmU/kPDj
 u2YsF7+icRmcV2R2lGuME8vC5o4qAf7j9+/ZFrKw6NHZceNglMZtY47Jjyw==
X-Received: by 2002:a05:6214:484a:b0:8bd:c5ca:3975 with SMTP id
 6a1803df08f44-8ca0f6c36f2mr288238846d6.46.1779223567542; 
 Tue, 19 May 2026 13:46:07 -0700 (PDT)
X-Received: by 2002:a05:6214:484a:b0:8bd:c5ca:3975 with SMTP id
 6a1803df08f44-8ca0f6c36f2mr288238546d6.46.1779223567121; 
 Tue, 19 May 2026 13:46:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361a7284sm108451816d6.40.2026.05.19.13.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:46:06 -0700 (PDT)
Date: Tue, 19 May 2026 16:46:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 03/15] tests/qtest/migration: Set file URI by default
Message-ID: <agzMDUSio19_2CWO@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:02PM -0300, Fabiano Rosas wrote:
> Most file: tests use the same URI. Make it a default in the common
> function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


