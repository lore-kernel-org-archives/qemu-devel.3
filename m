Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59673D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 23:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO2kL-0004J7-Gq; Tue, 25 Nov 2025 18:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vO2kG-0004IS-Fe
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vO2kE-0002Pd-1d
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764114406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8p7ImH6HHk/1bdYxNAo4EVjVzXBcyd/IOZ2yPopGvU=;
 b=ZY6XLpZNT5oYj/6FWgsFDqK/4YuG71XbnD9GSNxzQ1uPpQLCuAQVoxiY9Yr22AsXHqgorf
 qGPG4Uker+W5S9vgoexxHPATYCD27V4HY66BgdMgfzlos2R4JyK9zfD95VymKal3pWfzfz
 HqEVcubxItoYUcMYf92DbG22s+jASJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-PaqfpF9uN964rpbrl5chfw-1; Tue, 25 Nov 2025 18:46:44 -0500
X-MC-Unique: PaqfpF9uN964rpbrl5chfw-1
X-Mimecast-MFC-AGG-ID: PaqfpF9uN964rpbrl5chfw_1764114404
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429cbed2b8fso3323362f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764114403; x=1764719203; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z8p7ImH6HHk/1bdYxNAo4EVjVzXBcyd/IOZ2yPopGvU=;
 b=fKwHvLqMCzvr1mgWrOQP3kZl9Tk5FlldYtFcugxwK+BdgTfLw99wwdSS0oIpc6btXg
 zMVRmqkXByTmrSlog7up66GanXhjH+4KGCanZ7EEYzr/SjHbuG8OdCMpLSB4jxfX5pKB
 XBwyCJOr2ZKxIjPrRo/fxwk6Ulb6KHrnRysmeSE6ZKYo9TYoRubWtAXhhPa4mAvcBEr8
 Iet/S+RvWhhT73rnLu2J+dnaTUHmviBj9E8g2uO6sw29nU/coXT1L3pjP3SIeT+Q244e
 nVN8/E0lLLmNYWvSYfRd8I1W0ziKdx5bmIvMmBWbuXgEPYxnjZgCMdNldAedN242efdM
 YuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764114403; x=1764719203;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8p7ImH6HHk/1bdYxNAo4EVjVzXBcyd/IOZ2yPopGvU=;
 b=BkV4Kaq0qZ96kT5TczJm4ijCHYaAjJ2RUH0ddxMMz3bxcCRkVJ0F7BNWwlMH7B0x5w
 s3hdePaGE1hDkhhpa/mOYDI50uEKtU3Hw/zbVNIaOlqpacayWJqQsWcyxiTBW2clbjHu
 bLioZCYgwiAMiIaralLHx6KPcxOAF0ncdnUbD7grWEFV7PztPlI1B88J/ciQ1dfBGxqX
 dTS+D1MFMS4KVGxkLEIV3AlR1IChBDprRn3bB+lwLrknIYLVvWGU4PraFFoymYOPd1Sg
 26/JPwsx17uocsKmls7yE679LXflBMdH7wTef96ku0OSqUTIghp4ASXQfSWzDuIAthM3
 AIpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+9EuCluYMCHHMTwclOqsqFpm0lJrRw6dx/9iPP2Ki89EmFsMY7AhJzdtAGYczaXamC//JINMagil5@nongnu.org
X-Gm-Message-State: AOJu0YycGYILDMCO1PxqcWBEEdvrXJxGFn1nlcf1LgrD+5CfDW0lbLRg
 O30eBMk9BIR/Y1S8soGgs2rNh/5cGEsljAth1aN0ZCMl6RTWXhBAruLCE4Kf2m/1JL7+F9YTaWc
 z1+upier/yKmBzLlRKIvszIzk5qxKBtCZeGLBF5vrh5MzNioaJR9mOdHb
X-Gm-Gg: ASbGncsUWCv6JKiE6XBseFdYCrx6t5reKS+HEjra0LL49m4Z1sAACf1v8Nzt5XqKp79
 YECe0sA3jJ4cVVBogWLzbErxlpMQl8mH8kuNqf5fK/foCnr7G9TQ9Zrw+KUQ9Py/aUHmPEjkTWC
 J3hoRI5vHyw/2devveK9vaWh/ipECmVvhFpoha0hFWZloG+VlLaonMuw18kTj4unwl+cqa8ugyN
 vaRRrrvK8BCeDBjPLJSfyL5oIQvfjeCU2/5gxbDWVzYTlTt85G5YPuizuN7xk7coIstkFHcYKYe
 dvf4ZMUf0/IEshfn6eHrTyevakfy+A8he1hpTJFGL3Db0uqZ5/olVNE0k1Tk1fiTOj+9Qmo6P7u
 169TpuBUUlu9u9ppKSPU2E2eoX5iB1w==
X-Received: by 2002:a05:6000:178b:b0:42b:487c:d7cb with SMTP id
 ffacd0b85a97d-42cc1cf3860mr18566806f8f.34.1764114403575; 
 Tue, 25 Nov 2025 15:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGREEsm0Zffp1EJOk7XW7fZypVKbYfUSuHks27g2SAYdHN5PSFgbkjYwIGzRdaj3O0+Wdh3QA==
X-Received: by 2002:a05:6000:178b:b0:42b:487c:d7cb with SMTP id
 ffacd0b85a97d-42cc1cf3860mr18566789f8f.34.1764114403124; 
 Tue, 25 Nov 2025 15:46:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e5a3sm36864104f8f.6.2025.11.25.15.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 15:46:42 -0800 (PST)
Date: Tue, 25 Nov 2025 18:46:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci: Make msix_init take a uint32_t for nentries
Message-ID: <20251125184507-mutt-send-email-mst@kernel.org>
References: <20251107131044.1321637-1-peter.maydell@linaro.org>
 <2aa92f1f-7d01-44ab-b29b-a3f22ad631af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa92f1f-7d01-44ab-b29b-a3f22ad631af@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 25, 2025 at 10:50:22PM +0100, Philippe Mathieu-Daudé wrote:
> On 7/11/25 14:10, Peter Maydell wrote:
> > msix_init() and msix_init_exclusive_bar() take an "unsigned short"
> > argument for the number of MSI-X vectors to try to use.  This is big
> > enough for the maximum permitted number of vectors, which is 2048.
> > Unfortunately, we have several devices (most notably virtio) which
> > allow the user to specify the desired number of vectors, and which
> > use uint32_t properties for this.  If the user sets the property to a
> > value that is too big for a uint16_t, the value will be truncated
> > when it is passed to msix_init(), and msix_init() may then return
> > success if the truncated value is a valid one.
> > 
> > The resulting mismatch between the number of vectors the msix code
> > thinks the device has and the number of vectors the device itself
> > thinks it has can cause assertions, such as the one in issue 2631,
> > where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
> > msix as "97 vectors" and by the virtio-pci layer as "19923041
> > vectors"; a guest attempt to access vector 97 thus passes the
> > virtio-pci bounds checking and hits an essertion in
> > msix_vector_use().
> > 
> > Avoid this by making msix_init() and its wrapper function
> > msix_init_exclusive_bar() take the number of vectors as a uint32_t.
> > The erroneous command line will now produce the warning
> > 
> >   qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
> >     warning: unable to init msix vectors to 19923041
> > 
> > and proceed without crashing.  (The virtio device warns and falls
> > back to not using MSIX, rather than complaining that the option is
> > not a valid value this is the same as the existing behaviour for
> > values that are beyond the MSI-X maximum possible value but fit into
> > a 16-bit integer, like 2049.)
> > 
> > To ensure this doesn't result in potential overflows in calculation
> > of the BAR size in msix_init_exclusive_bar(), we duplicate the
> > nentries error-check from msix_init() at the top of
> > msix_init_exclusive_bar(), so we know nentries is sane before we
> > start using it.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Technically this fixes an assertion, but only if the command
> > line is daft, so I didn't think it worth backporting to stable.
> > ---
> >   include/hw/pci/msix.h |  4 ++--
> >   hw/pci/msix.c         | 10 ++++++++--
> >   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> Queued, thanks.


I felt it's not 10.2 material, so deferred review. But if you are sure
we need it, ok.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST


