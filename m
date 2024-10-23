Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514A5CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dsJ-0001A1-Uc; Wed, 23 Oct 2024 12:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dsF-00019Y-Qh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dsB-0003ZG-Km
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729699564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HBDpmTZnKrEUQm/wc6K0Lz5OaCXB3WOlYnaziIhAbzo=;
 b=LBxFJiGsIJ5UBWCxmzPbS1f3KJEYTwc+38cDqquYHJo+ZeF1A6SM1T2WNbifgfG4JqpUPi
 JJqfNgpsvVppkgY3mEy9882YXXS+IPd9mT3Zu1yWB+POXDbsXHAv/Ccx8RiUGlVtEJ7AOb
 gZLfEeQCRnOxdV7Tx1ZHysjufJ1DFS8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-TL1lfR1nMKieZTRZJH6_pA-1; Wed, 23 Oct 2024 12:06:02 -0400
X-MC-Unique: TL1lfR1nMKieZTRZJH6_pA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so3650061f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729699561; x=1730304361;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBDpmTZnKrEUQm/wc6K0Lz5OaCXB3WOlYnaziIhAbzo=;
 b=CK4PJX3O3rGoZV63JH/lsSOMzeE5aOV3GSGXBQuMCwHmba9mkmHQ9FTarF8k+ANxYe
 bkpA13+jzBsnmy2/urOA7PJebqDjGOP2vf08r4nMbhbnkEOJeHl8KT28lNWywh+99aqw
 B9cl2GnO5OHvEZ4wZq48PNtQaQfPuJm0z1iAw4oTZiim6VLjkTOf25GbmNXYdHxA138i
 jOj1zg4Qx70XR7EdF54AObs1l+aqIyBQzHYZOecJgiQq/1iCwJClS9+s/RgojONKeTzG
 llnsvrCJ5i9WeOEbx1vOibQcV7VdJfX1EH1uPOgGDKTxfIoPYw/ISM7p1oCHpgl2Jsp8
 MOrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNH4jodDHWhskvv1VZMY0MpXw8Xhsr2idC5SCBve+OXldPwoP58Kqk9kBudirimPaJHWJ1O983V+I8@nongnu.org
X-Gm-Message-State: AOJu0YyD/CIQcbMqiAli7bZE4wu+BR8l6XY0ixxxOprkbaz5TU694+xa
 HsiwLdfIFiNAih9BWIA7/ZrCcvue79bAH0TcI21Z/X5WQ8i2Z+/Q/tJKwZ2PfsrTmZerJNOgMdU
 WWVqe/waohw8RiG5b3lg6BF4SS4/VxQW+G+MqN78noOYO4TgUHohxErNj3gc8bjc=
X-Received: by 2002:a05:6000:1083:b0:37d:3e8c:f6fa with SMTP id
 ffacd0b85a97d-37efcf1dd1emr2035403f8f.31.1729699560781; 
 Wed, 23 Oct 2024 09:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHjdZlo3P7kODeSIRA47U8FeyacZWTPt3jWNCX5YnPW+Dkh0GlCdg4j4Sg41kbk3dFOXrGeg==
X-Received: by 2002:a05:6000:1083:b0:37d:3e8c:f6fa with SMTP id
 ffacd0b85a97d-37efcf1dd1emr2035379f8f.31.1729699560397; 
 Wed, 23 Oct 2024 09:06:00 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0ba7c27sm9194322f8f.115.2024.10.23.09.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:05:59 -0700 (PDT)
Message-ID: <eca2be66-957f-493e-b788-c2f3c927821f@redhat.com>
Date: Wed, 23 Oct 2024 18:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 11/14] monitor: connect in precreate
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/17/24 17:14, Steve Sistare wrote:
> Complete monitor connections as early as possible, prior to
> qemu_create_early_backends, so the user can issue commands during the
> precreate phase.
> 
> Make a list of the chardev's referenced by all monitors.  Create the
> chardevs, then create the monitors.  Exclude monitor chardevs and
> monitors from the later creation phases.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   system/vl.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 3c592b9..a985ab8 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1939,6 +1939,11 @@ static bool object_create_early(const ObjectOption *opt)
>           return false;
>       }
>   
> +    /* Reason: already created. */
> +    if (g_str_equal(type, "mon")) {
> +        return false;
> +    }

This is incorrect as mentioned by Peter.

>       return true;
>   }
>   
> @@ -1956,6 +1961,68 @@ static void qemu_apply_machine_options(QDict *qdict)
>       }
>   }
>   
> +typedef struct NamedElement {
> +    char *name;
> +    QTAILQ_ENTRY(NamedElement) next;
> +} NamedElement;
> +
> +static QTAILQ_HEAD(, NamedElement) monitor_chardevs =
> +    QTAILQ_HEAD_INITIALIZER(monitor_chardevs);
> +
> +static void chardev_add(const char *name)
> +{
> +    NamedElement *elem = g_new0(NamedElement, 1);
> +
> +    elem->name = g_strdup(name);
> +    QTAILQ_INSERT_TAIL(&monitor_chardevs, elem, next);
> +}
> +
> +static bool chardev_find(const char *name)
> +{
> +    NamedElement *elem;
> +
> +    QTAILQ_FOREACH(elem, &monitor_chardevs, next) {
> +        if (g_str_equal(elem->name, name)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}

No new special casing and no tricky differentiation of how a single 
command line option is processed.  If you need to create monitors so 
early, create _all_ chardevs and _all_ monitors; same for qtest.

Paolo


