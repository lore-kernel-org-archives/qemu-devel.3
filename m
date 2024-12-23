Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB52E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmFv-0005Gd-5z; Mon, 23 Dec 2024 12:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmFt-0005GQ-6m
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmFp-0003T8-Qc
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734975003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+mJXVTDIWQ6hiAPg1P3EQdyDKJQSkpgrJsRXEZFQt0=;
 b=JeCqKhZmf+gDEokW7CquPJZ5NTRWVvtTn6tg8LqHiVknDcVuRdUgYOBUXjfS9Vt5hveyZZ
 paHLClnHL/XU+Q1ZRFTFSRsuG0HiloyQ5vBu1Ps8MenAThgQ7SZ28ZX/cNm2Dv3P+9bMU+
 19dhkNkt4RoIzlRybx8QYHdHS8kEbUk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-guatZMIIOauJR2QT1i3LjQ-1; Mon, 23 Dec 2024 12:30:00 -0500
X-MC-Unique: guatZMIIOauJR2QT1i3LjQ-1
X-Mimecast-MFC-AGG-ID: guatZMIIOauJR2QT1i3LjQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e6cf6742so1163655285a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 09:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734975000; x=1735579800;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+mJXVTDIWQ6hiAPg1P3EQdyDKJQSkpgrJsRXEZFQt0=;
 b=kAresMjUQHsm8uPzifM9IXqhU+IdOD+FNjSazIq5SRZdCQTHoh7PrR58C7wd7d85eb
 3VLwCm1/yvQMRCKnYdtS+24Q0/1HeYPI1Sozv3/3/13Pyc/91Zwj/NAJzkx4RzARiZfd
 Efflx5Ed1Um3Q7vk9NCjgM9xILw9pcRXBCziBnsHSsvh4iD0YeknPNj0tmqgKv9lgPcd
 taCoPeJczkIwAI0+XUVK3fc7A0DKFWOQ+PmK5YMkjdsT8Ww3QZXomJBKoh64eQjswEot
 sNx0Mdeg9zgZeRlIMQzxD17pVhs2xtZvv/udaYWg8O8W6BcpYKh4HCBhiO0aiq2o/rEl
 bt+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl8sHXWEMsXRNrMTpSIsuFru5XKcqu08+o2dKORbJzrh/19/SnuEdvt1A3FK5hEpp1AG/3ZxD08iMD@nongnu.org
X-Gm-Message-State: AOJu0Yxy15K0iRC7j9voeq05V/6IW7ge/sPMuwdmJj7Rk4p7rTQVXZZ/
 eG3RRsxY4sODMOR2ubqMtkZNk13GAuA5XnQh+pXFj0/yZbzA+esw/Hu/l0DKIKBLOuEV0B8vJTa
 Ol7tejSV+PlfZ9VxWP5wGRP+Ez4K2EV4nHc/LtgbjlkS7w1ky3Bg+
X-Gm-Gg: ASbGnctRSWWzH/vsmnQQ/IB+IlooCyg79JO3ZUkcqtXCqR4DDjIXLhfjh95EqhVLtB+
 FNoprsqhyKffCvhaed3Ws+7zhly6dkbQwSy2N5kEoEZkfjD/Bq/ih8AnbxhzFXrEEvm0+9ViXgH
 UeRFnyQQMCQ5mxdfmXh0fMCxPQLSReZubFMYreolIUPNEBnwyFZfNx7okF3hPsH5n+LXWxZD6jz
 Lv5YcbbdlZxODyqOt2A/to2n1Ozez0ZlnU8SLp7EC/YTPCqjbzIDxP89qO6f4qOKaC+CoCXRaJk
 Emko06L+172NPBKTtA==
X-Received: by 2002:a05:620a:459f:b0:7b6:d4df:2890 with SMTP id
 af79cd13be357-7b9ba6efb22mr1875439085a.4.1734975000486; 
 Mon, 23 Dec 2024 09:30:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzEJFPDaiPpm95oJcIXO6EYQOq57th1Iax2eamWFuOCZgoarv952uUJHA7CEXSnY3UbQOqAA==
X-Received: by 2002:a05:620a:459f:b0:7b6:d4df:2890 with SMTP id
 af79cd13be357-7b9ba6efb22mr1875435585a.4.1734975000231; 
 Mon, 23 Dec 2024 09:30:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30d319sm399718885a.55.2024.12.23.09.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 09:29:59 -0800 (PST)
Date: Mon, 23 Dec 2024 12:29:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
Message-ID: <Z2meFeW4YvWjXIdJ@x1n>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
 <dbe21846-ea9e-47b6-83c4-6ee350e891e5@linaro.org>
 <a0e5950d-2de8-4500-8376-88c231818aed@linaro.org>
 <fe9d34bf-5a68-42e3-ad00-c8f22551865c@linaro.org>
 <Z2WoVxB8GfdJj6KM@x1n>
 <1c425eb2-6f67-49a9-8e4e-f7477d54ed55@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c425eb2-6f67-49a9-8e4e-f7477d54ed55@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Dec 20, 2024 at 10:38:40PM +0100, Philippe Mathieu-Daudé wrote:
> > OTOH, this works for me:
> > 
> > ===8<===
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index b09af8d436..009b7695f2 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -819,6 +819,11 @@ int main(int argc, char **argv, char **envp)
> >       set_preferred_target_page_bits(ctz32(host_page_size));
> >       finalize_target_page_bits();
> > +    Object *fake_obj = object_property_add_new_container(object_get_root(),
> > +                                                         "machine");
> > +    object_property_add_new_container(fake_obj, "unattached");
> > +
> >       cpu = cpu_create(cpu_type);
> >       env = cpu_env(cpu);
> >       cpu_reset(cpu);
> > ===8<===
> 
> I like it, simple enough, allowing to remove container_get() now.
> 
> > 
> > So we need both "/machine" and "/machine/unattached" so far to make
> > linux-user work.  Not sure if bsd-user/main.c needs similar care, but none
> > of these look as clean.
> 
> Maybe add a common method in hw/core/qdev-user.c?
> qemu_create_machine() or qdev_create_fake_machine()?

Sounds good at least to me. I'd vote for the latter to reflect it's unreal.

Thanks,

-- 
Peter Xu


