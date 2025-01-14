Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B213E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkke-0002e9-4T; Tue, 14 Jan 2025 12:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkkb-0002WI-Bz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkkZ-00088T-TA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736875846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLCtmFJaf6yqYSb9krUp4dOe4vP2n6jqDSwJ7+L73sc=;
 b=NGgcQy41N1uvGnTDK+u+omhUha6usxvzwgabQaFsDHQ3bCIlCNWF1tB+8kN+yi+st4GGaY
 EEr9sqiH2WLKhGOpDy3pxQqUe1LGEvMXx3fHFWKAQzlW7w6iNCIiHBPOra90CsTVBWGWQ6
 laZWdkWOsU8VgjOUx60T9OSrU/FSZKo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Rv_ZoRpoM7W565zvdYG-FQ-1; Tue, 14 Jan 2025 12:30:44 -0500
X-MC-Unique: Rv_ZoRpoM7W565zvdYG-FQ-1
X-Mimecast-MFC-AGG-ID: Rv_ZoRpoM7W565zvdYG-FQ
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2163d9a730aso109516585ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736875843; x=1737480643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLCtmFJaf6yqYSb9krUp4dOe4vP2n6jqDSwJ7+L73sc=;
 b=lp5HRUTZubhiIflngCA8W+ykNmTrGJyp2yy4iPltv2aRYiXcaWO4laykYCppGIcX+/
 gyAJoNXOmOSu3ATdkyJ50x+yUeWw08zqz739uYn4FscfXzIny2VdTncCc63zrNnqzv5l
 6xM0v/VEkHiMnQQttj5mOlnVVI+56NBta35vfxL3OHYmFfozmrT8nneMN5V34nHvTj7Y
 R5CppsxuXModYOMycbABcJHE4Qs0ZHMrWEg67s4ePM2IbdLpfr6tF40tOAWQ4XoRmNiR
 3FatZdHuC9AHiwJHOfJEpVDgecj+RcSrgBsjYY2tXAwZJGGF7TUcQK/pJ0Wpcx/Hflhr
 QDew==
X-Gm-Message-State: AOJu0YyPpEfTtUViL5nx+t/X7RTHQ3BRD+3mYeYhaOStIYZZZGg6U6Oz
 KwhcPPgBrooki4EUGFSjCj9G1xFgMZWr+YC9iogjanBUEVr8ww0pABVbZnFasSVXO7efuUz/ml/
 2g8OROXZkUZTiaRm8r/1L+kVhdNMsTvhhmDKa5UBJuQTzEHj9fZQP
X-Gm-Gg: ASbGncsTU68PCn7AmVurbCT7HEU7jr+lfOA05MC+gQyOtwloQc4mYmoRuYcD6F7UngQ
 8OKyk9NalcEMaPjgmb7v338DSjW2bTQYtCGiIVdX3hC/vGXu2uYJpphyZukKvZCFsq03yQMnoRe
 L4FgPSPKaPL6GDyEWSmgyufcQjHSci2AMScyHzrjDB49uE25LxSisQwOq/bJyecdr1XHC58W4lG
 bVVlwh2sjeyYUzEJf2HLFDeR2SRDuPOlmDFeeRzdGSLIkSScOp7KL16C79HVZZv6KEGY/nrgT67
 whm36ZIiLEHh00xMNQ==
X-Received: by 2002:a17:902:f652:b0:215:5600:18cc with SMTP id
 d9443c01a7336-21adf6b69cemr212993305ad.22.1736875843448; 
 Tue, 14 Jan 2025 09:30:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoSfcRTwRRrWcK1KNgExW5mJJcPeXyz3lYSsPvGyHo2ePz8RAYpkP2dr/fnmpSOZnP6+lEwg==
X-Received: by 2002:a17:902:f652:b0:215:5600:18cc with SMTP id
 d9443c01a7336-21adf6b69cemr212992985ad.22.1736875843114; 
 Tue, 14 Jan 2025 09:30:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm69554815ad.103.2025.01.14.09.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 09:30:42 -0800 (PST)
Date: Tue, 14 Jan 2025 12:30:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V6 22/24] tests/qtest: assert qmp connected
Message-ID: <Z4afP3tqqstac3og@x1n>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <1736875434-106563-23-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1736875434-106563-23-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 09:23:52AM -0800, Steve Sistare wrote:
> Assert that qmp_fd is valid when we communicate with the monitor.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


