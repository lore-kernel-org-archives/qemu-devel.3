Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D57FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0ZC-0008IR-7R; Wed, 29 Apr 2026 04:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0ZA-0008I2-85
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0Z8-0002af-IA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777452401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kz1uzSATI+wQiospVHcrJHYUfESAxUB8gFZrtyhc0ZY=;
 b=dZHAv2sloeIb/apm2jFSY+kLqG0lZ2IV6Z11FsTCf/efzAe9KkvIWgRC0SUK0fKMceZVR5
 0WAqq51EhIsmFTuAdAj4sdfEocky39fz+0BHY7gbS4oHX9o6O3A6zXjk1IN0BoYSN37rzY
 J7fhhzvKQmnih58RHX4QRiD8G1hfAdQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-tfwZBUyNNACortIcCI4yfg-1; Wed, 29 Apr 2026 04:46:39 -0400
X-MC-Unique: tfwZBUyNNACortIcCI4yfg-1
X-Mimecast-MFC-AGG-ID: tfwZBUyNNACortIcCI4yfg_1777452399
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b1f39c5827so159322906d6.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777452399; x=1778057199; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz1uzSATI+wQiospVHcrJHYUfESAxUB8gFZrtyhc0ZY=;
 b=Qg0R+7wzT4iOtvAgg5VMqKiU+RoO6J+uPeTmS+pxNsxBr1CmG7AoBvWyvZgRXnSt8+
 P8IVs7W3SodELW9luqh0ub9a0MbVSYg29Wqxgm2yysY3yxdf657jHk6T7tf/h5pC6kzg
 BpM5RDnz5vSu2YsjCpoux3C/THh7v9c2qM6MaUnHYtMVET7Zf1BPynMCKvhz6LSk2SW0
 3z5W8jWEY30x1ULY4tUaQqku8wRsqJd7su0CK+k0AotS9ByUEgpDFuDpWpEzr0ZpjaBZ
 3JnkDl+oUm6FYtRUeiaj1vsoMtUV1sxROAiopxDCc/Lrgqw/lBX0b7UwSnvwt/fFbxzM
 Magw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452399; x=1778057199;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kz1uzSATI+wQiospVHcrJHYUfESAxUB8gFZrtyhc0ZY=;
 b=W1CWi6gSVXBEk+XoqVZohcRZMD4UytPux1ZcxzviL5NqFezuA91fQIfWAa/zAfeF6G
 jGKEgerfB7DeXRsOTNMzwU4uA5AUwvrej76fn+Olk1fhm58D/yUMXnmmnAP9nbmRIL/m
 bTM+YaTC2rMFuEXutU1wWbQaH4IRL7KYPh066vfPqP9a5VdhnFL8uDTYeFd7Ct6mZyxW
 OewSwFIkhym4bRQ+HwKqZ+lQ9oL9e76NVtkn1McHB9EKlOTWxQROh9ChlkK9n1/wGRhN
 jYUgz9PDEDAN21dXWZTH0vb0nabYoPmh4MUE9tYt3BIBAa3OmMYWHdYcGy83QmlxZMbj
 bzQg==
X-Gm-Message-State: AOJu0YxZNIK9BWj3QM7eB1diwwM40P2+Hm2YC+prW2m9SKX/80VENoB7
 0Usxb2twXaw2MptAVKjHXlZRE12VpI4WtgSU7RURIkd0Tuw5pLcbtvbWxGfai9+S/pyrLG9L+t7
 L+QfJZ3Twyz4vfG9hN2uhawioNCGEa4oI4tMwByfs4Am6CC261mNDA24T
X-Gm-Gg: AeBDietS5p96xLiLyiQb3aibf5HUlPminh2MNkaQrFjpUjOYKlGJR0M2cC1ri9mwG1g
 EADWQ00e85kmTVjaX5T6dIFPp8/OXvFMAN6dso3OvgzslnB/tZFYnJcnKUQZsogF9N/ytlyLq9V
 hgA6/bpEaXpV1ha7qzJBq+ftKh21NK1ehPnJPQ/MDSW33f7wtu+0KWbtTaXipZu5XBHTqpE0tSh
 RH3V7zjdtHdZm6YORlHaHzDbIZ9MeMR+H0evxPrvBV6csXDQHvvDkkzdau+LQnTxvEpDmR0HfAW
 fwk5QlbxLa3CeAy3glmoZyOFSFrs50tgjizJ8KIfxMToC8lckXJQUgfzUdXihpO2rtn03GBo2fT
 m2Csakt3v8G+RvCHq3WdC1yoEOLYD2e8=
X-Received: by 2002:a05:6214:260f:b0:89c:a2b2:8d3a with SMTP id
 6a1803df08f44-8b3e304e936mr102468006d6.4.1777452398942; 
 Wed, 29 Apr 2026 01:46:38 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:89c:a2b2:8d3a with SMTP id
 6a1803df08f44-8b3e304e936mr102467786d6.4.1777452398411; 
 Wed, 29 Apr 2026 01:46:38 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef7ea763sm12925056d6.24.2026.04.29.01.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:46:37 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:46:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/6] system/vl: initialize QOM first
Message-ID: <afHFak0kkt2fiL0P@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-4-pierrick.bouvier@oss.qualcomm.com>
 <177745176384.2166241.6921788598496135839.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177745176384.2166241.6921788598496135839.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 29, 2026 at 12:36:03PM +0400, marcandre.lureau@redhat.com wrote:
> On Tue, 28 Apr 2026 16:45:16 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> > diff --git a/system/vl.c b/system/vl.c
> > index 0e1fc217b4f..b4a5ea6f857 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -2889,6 +2889,9 @@ void qemu_init(int argc, char **argv)
> >      os_setup_limits();
> >  
> >      module_init_info(qemu_modinfo);
> > +    /* We need to initialize QOM first to detect target */
> > +    module_call_init(MODULE_INIT_QOM);
> > +
> >      module_allow_arch(target_name());
> 
> This change is not trivial. By moving the call here, we lose the
> initializations from qemu_init_subsystems(). Verifying that all
> type_init() code is safe to run without it is a tedious task. It might
> be better to introduce a new MODULE_INIT_TARGET_INFO instead

I'd be inclined to have a MODULE_INIT_QOM_EARLY, along with a
type_init_early(), so we're not presuming target info is the only
use case for earlier init.

Regards,
Daniel


