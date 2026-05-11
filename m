Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B7CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVjC-0007uX-9h; Mon, 11 May 2026 14:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVj9-0007u7-2Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVj6-0002t6-Sf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778525496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZE0aHY8LTHR3vaNLyCsOVAN7ZopvEVlo3E8AOJCnxw=;
 b=KpLXi2RiKUjkrHOUVMHdK6l698kNmM6UKFU8jgJESN6EwzOUocPi3zY+05Lo9jMRmlq6lu
 gbr3SdCjxcxMbh2aa3dhQFKldU9rkU7A7dmHFaqPNAniWoqA1Mmaz7mKZDCP4pKMXbaiWt
 z6YjLJUsETW5L3aUG7QJq82SieBz9Sc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-UoQEA8JbM4C2DYB0eNEztg-1; Mon, 11 May 2026 14:51:32 -0400
X-MC-Unique: UoQEA8JbM4C2DYB0eNEztg-1
X-Mimecast-MFC-AGG-ID: UoQEA8JbM4C2DYB0eNEztg_1778525492
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50f13da9684so29446781cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778525492; x=1779130292; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BZE0aHY8LTHR3vaNLyCsOVAN7ZopvEVlo3E8AOJCnxw=;
 b=quA1VjgecDtPxcdXdgQgsyeQxIDLyTmaF6uLG8IwwwZpgtP9wA4D7Rens+CjWM9btf
 ytXLq70zdZqFX90c1J4Touj45DRmLUI9iNg2CHe5bijQ8mQHFwGTAfvy2UCvJBWr+mti
 2GtohsBJP4OD5iPSDyetRtl2wdIpMJNPyeKY1RrFen5+BrZRdU3h1wMM6oYv1mSsgrgO
 J2Lm4E7DyZXyLggx0m74w3X+3wT1qBCOntO5ahmVxO3NwlU/nOt4dzZnrUWvbsRgwjmk
 fInWccRxyBRRVHcqINGz/SOGoFXpUvwCRVetv0E3IFKqV3GbhIpb1JmYQ0nA1Okb2kmI
 og8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778525492; x=1779130292;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BZE0aHY8LTHR3vaNLyCsOVAN7ZopvEVlo3E8AOJCnxw=;
 b=URqW4aGAmgtFfLx4a/cfS/Ai7pYQFaiA925jMmorsHpYSA5J0SYpF9QYE8ak85dnIi
 CibcnM+B/IE1y8VeMyUfEONDENtr2ODbxVx2agy911AmxjH67Gsd/EAXVnjq1IasPrlN
 gZ2pkufuQbawCsOfrSr3EA9guq9X0PRKaPuM6QyEUK+7on+ubNNv39CM2fYyf0//HCCD
 AYqmXFj+f9kuvefPx1zwHMrw5GKon1twEaR6OFpvR1kcjrRHRr8OCabYwUO3Zi4Hq1L/
 LfkOJYc4a+4JZS7v2ouGZZ7x6IC6APZLNmqrKhTgYZTtqzwHb9YOhJ6Wb3R6FIWKDFJK
 qaqg==
X-Gm-Message-State: AOJu0YzUdSoCJrChkPybhVFaQVj6WqYCuGhs8mVoM12TUL0JNPBCFs4h
 8Qsfsvxn0/FYitevoTluFjH2UcmTbQt3h5cceX8nf/xLhq7JL7vanwANXKruqrIWN3edB5EL5Ez
 ogY7Vmjkj3j1ktH3sWqGalTfc+gdG6r8LgD6YoWRI4BIQZQhYJGv775cj
X-Gm-Gg: Acq92OFwstdDZOEqBTtd6WVl7IOV6llimrjduXg1QycIoE0Plp1W4ZS8z6UtHelDlrU
 eev1T8LtB6LLQzEMmX2Ell6xYrSFfceMi8Q5a4gh1Fd5eOvJvzGKoYzSDsXbIjv8+Brk5vDg58O
 JOUJERxdqgeS7xki6b26oB3hXQPmXVgt2n/td3QZcEDfvLrOt8h57cHFlOPeRHAx4Hg/+PyUvC6
 qJbv+v2EoRchIOhBdz0BCOz+xO5QDDUqGsF1GRs+dINGJtUVLiu8+8F6q44TOOlzLphDsoem8qI
 cyIaQ5kDlAi5ekkfdvbyKj8vqFAJxtIVgjegq3/uI5cgcdxsHt3PKsU51AQTeydaxJ7lYDS/xZA
 hXdha1o8/EiM1VPhcEx3xUarKxZvjrjLedoM+OYSMdAR++ME=
X-Received: by 2002:a05:622a:6096:b0:50d:6baa:9e9c with SMTP id
 d75a77b69052e-51461bea15amr340975791cf.6.1778525491750; 
 Mon, 11 May 2026 11:51:31 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:50d:6baa:9e9c with SMTP id
 d75a77b69052e-51461bea15amr340975321cf.6.1778525491136; 
 Mon, 11 May 2026 11:51:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e7bef56sm97611941cf.15.2026.05.11.11.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:51:30 -0700 (PDT)
Date: Mon, 11 May 2026 14:51:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Remove VMS_MULTIPLY_ELEMENTS and
 VMSTATE_VARRAY_MULTIPLY()
Message-ID: <agIlMU-kwGyyfJla@x1.local>
References: <20260507070228.48877-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507070228.48877-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 07, 2026 at 09:02:28AM +0200, Philippe Mathieu-Daudé wrote:
> Commit c1eb3ac3468 ("target/sparc: Replace
> VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY") removed the
> last use of the VMSTATE_VARRAY_MULTIPLY() macro. We can now
> remove it as unnecessary, along with the VMS_MULTIPLY_ELEMENTS
> flag and the associated tests.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

queued, thanks.

-- 
Peter Xu


