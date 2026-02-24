Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CA3F3C997
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuHi-0001jv-9z; Tue, 24 Feb 2026 10:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vuuHh-0001jI-1Z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vuuHf-0002Jd-1N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771946707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68cPhAhKsl3l7wlB9i+mu4XwiOvGR96PoAMAkZInQ34=;
 b=S+Y1C4SxzTQb6MKYd9LB9L+nOWLIQxnmehke9ode6rPfB4jKAwdJagipn4iIbMaBsMVjhF
 +N7Wsh9fVBzns76e2aFI/EdPpiYglPSiNrqdiP+eZ1AQIDssGrcoP/6PPM8Ra+b1QaZY2D
 ARqTXXnkXzM5xbYzoN9ibfT+5lCdouY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-xdpVQIv2OSmWMbP9_rKkBA-1; Tue, 24 Feb 2026 10:25:05 -0500
X-MC-Unique: xdpVQIv2OSmWMbP9_rKkBA-1
X-Mimecast-MFC-AGG-ID: xdpVQIv2OSmWMbP9_rKkBA_1771946704
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso3736641f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771946704; x=1772551504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68cPhAhKsl3l7wlB9i+mu4XwiOvGR96PoAMAkZInQ34=;
 b=YNjDZURoVGmi3DVdRQ09NvA/+Lb912Pm5VamyIfSsOLzz56rgiyu3GRYmcjd7RrWvk
 1ajV1W2dB7PIu6dkIJShbDWzdmrGk0HYHaqeVhhP6YVSQUHFl8H8WdRx1498q1/HRz02
 dZ8fPu1Q0O+KiPhyLYKbSkCRWL/diVHILegrEzYejJF8sv+Vq0ntEAUC+BmJOzmgl2nK
 PT8F/EptrZATakh8HnFS/J6LmdnAtj/AMEbeKi3rpS8C11qWmpRGHRGAvrhjQ3dWgt1k
 ehHykduUzq6wgCU4i4460g2lKTSmn9XHm9ewtKSI5/gRJvlM6sPuW+JaEPmid+bw0agD
 NVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946704; x=1772551504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68cPhAhKsl3l7wlB9i+mu4XwiOvGR96PoAMAkZInQ34=;
 b=bHhKLT1/HdIhUt1W8IIIMGtMVt//LvWlSPIrXtkLTk9PYjpCK3wKRhiaCVdh4+MiiV
 gzPNUt5ApN/YM5vbfPOGloY65xp+3cgxoJP4T0vEk+HgL6PjBBIBXB1RWBBCzlJj8Kz9
 0XOCcPpnWgnXoWIBek5MeITmo2gzOzNis0wEFOJ7G33tjcFuMMODT1DmrbooTFPIM0bk
 7B8eFRIZlKSkpblzesyOblMeV+OGJ/eTX/jHbuJCeGFk9yqKagJ7AKCblk1ZSmTF3rDj
 I5FPkAbDQIxBZp2Zug6fGgyGwlxoiXoa6cWUkNI5J83es1hztj7O4kMvKD9dFuGfryqz
 6a/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzrUnEIUwA+jiP+BQqC7DQjbD687cXSfHlzkDZbQ2EeBbIU95k6g5fZ5iG3Sh0jsTU0ZGDYJtxzn/0@nongnu.org
X-Gm-Message-State: AOJu0Yyb/EPlYf7i+GA3Jg8C2lyAg+DkSg8ZSSJ1rffRmZV4OqS9IoPZ
 2McC4By47ijalgQbQBlX95Awx9E6fFrerbVz3MsAP7fl7mMMG+CI4nKdGf8Pe9kJ7R/69e6lu8K
 UGuWZp3r4h1FEbpigcwFbxPfBRkrHBytY4aFmtImcuEwHcu9SjpdHyZsz
X-Gm-Gg: AZuq6aJBoh4nNUjwCsYZTPSisaDCIE6W5+WlDah106dnj+roCpmqYbVJg80Z9tUWenm
 WsIpvJWFh8aOQL+5iGicvkN7ns31qmNC+gFMdB240MsQlgwmpAHj2TvYrCzOZRmNyNQrrkJCRv8
 GpiZrtZcEN2VlfZ2qs0dOFHVq6cF4pyGKXKpDZwpoG/uOrnElUnzQNyxH2WUDaO3DrZypKCur2x
 JNzIvM25qo2QcD4FLB7EB4khy3de+W+94Akzy5xsPpv4NMMaHvLEw6aTPs2/ZJv6wluJ/KvCiff
 +rJf993Q/i0q9WE4yK68D9P2MFHiG0fcuIn0vawNH4Ud7MOOareUX2MgqEAgb2bKp3RsEASVvIA
 /v0Gcx/CXT6C9CDcDirIVy6UiiAdNxzm8Em+LFVKSiWJwkfvkc0WuixIil5C+RlO4Ecz4hZVKUe
 YSj5tWWnKWk41SLKjRfvbphoqwz+6pCcVbSDf3hYzUIh+j9nKGcpA=
X-Received: by 2002:a05:600c:37cd:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-483a960604cmr189183215e9.30.1771946703729; 
 Tue, 24 Feb 2026 07:25:03 -0800 (PST)
X-Received: by 2002:a05:600c:37cd:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-483a960604cmr189182705e9.30.1771946703280; 
 Tue, 24 Feb 2026 07:25:03 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d0d8:e3c4:2336:3d25:7aa0?
 (p200300cfd737d0d8e3c423363d257aa0.dip0.t-ipconnect.de.
 [2003:cf:d737:d0d8:e3c4:2336:3d25:7aa0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b8195f50sm31916325e9.0.2026.02.24.07.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:25:02 -0800 (PST)
Message-ID: <163144b0-c56f-4582-9d4d-834fe44ed8ad@redhat.com>
Date: Tue, 24 Feb 2026 16:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, kwolf@redhat.com
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260122160113.1147745-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260122160113.1147745-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 22.01.26 17:01, Vladimir Sementsov-Ogievskiy wrote:
> Now we have blockdev-replace QMP command, which depend on a possibility
> to select any block parent (block node, block export, or qdev) by one
> unique name. The command fails, if name is ambiguous (i.e., match
> several parents of different types). In future we want to rid of this
> ambiguity.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> v11: rework separate warn_s into one common function
>       check_existing_parent_id().
>
>   block.c                            |  6 ++++++
>   block/export/export.c              |  6 ++++++
>   blockdev.c                         | 21 +++++++++++++++++++++
>   docs/about/deprecated.rst          | 10 ++++++++++
>   include/block/block-global-state.h |  2 ++
>   stubs/check-existing-parent-id.c   |  6 ++++++
>   stubs/meson.build                  |  1 +
>   system/qdev-monitor.c              | 20 ++++++++++++++++++++
>   8 files changed, 72 insertions(+)
>   create mode 100644 stubs/check-existing-parent-id.c

[...]

> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index be18902bb2..ca14135191 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -593,6 +593,7 @@ static BusState *qbus_find(const char *path, Error **errp)
>   const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
>   {
>       ObjectProperty *prop;
> +    Error *local_err = NULL;
>   
>       assert(!dev->id && !dev->realized);
>   
> @@ -601,6 +602,18 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
>        * has no parent
>        */
>       if (id) {
> +        g_autofree char *fullpath = g_strdup_printf("/peripheral/%s", id);
> +
> +        if (!check_existing_parent_id(id, &local_err)) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +
> +        if (!check_existing_parent_id(fullpath, &local_err)) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +
>           prop = object_property_try_add_child(qdev_get_peripheral(), id,
>                                                OBJECT(dev), NULL);
>           if (prop) {
> @@ -613,6 +626,13 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
>       } else {
>           static int anon_count;
>           gchar *name = g_strdup_printf("device[%d]", anon_count++);
> +        g_autofree char *fullpath = g_strdup_printf("/peripheral-anon/%s", id);
> +
> +        if (!check_existing_parent_id(fullpath, &local_err)) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +

Node names and block export IDs need to conform to id_wellformed() (or 
id_generate()), which does not allow slashes. So the paths should never 
intersect with node names and block export IDs by design.

With these checks removed (or not, if you think we need them, they don’t 
hurt either), and with the spelling in patch 4 fixed as per Markus’s 
suggestions, for the series:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

(I know the discussion around how unique IDs should be is ongoing, but 
FWIW, having unique IDs across the block layer is good enough for me as 
a first step. Well, I guess, including block job IDs might be nice, too.)


