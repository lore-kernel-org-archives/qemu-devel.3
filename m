Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4948C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrCxF-0004pj-Ko; Tue, 04 Aug 2026 07:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCxE-0004pT-He
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCxB-0000Z5-UK
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785841501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPso8bybjvlzpSiniMJSg48FKCs4+i7LpgHDKwGEwWY=;
 b=PH6gVu4qkLHrGcedf4ePjad0/JbP/cnmzZDePb8CkyRIiZlx5B68h3i0kwi9pmpMpDhK7y
 vJhYmpkpj9GZjWohEboKJFdhHHr1O5KEIr3ALyRRLpuNcinmCqiQlINVD+widdQH1jt9wm
 2mTZUFGZbFYjNfmbWehRqlLLWA+xhS4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-0PlXR1gYNbWZRdP5gj7f_Q-1; Tue, 04 Aug 2026 07:04:59 -0400
X-MC-Unique: 0PlXR1gYNbWZRdP5gj7f_Q-1
X-Mimecast-MFC-AGG-ID: 0PlXR1gYNbWZRdP5gj7f_Q_1785841499
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496c06ba017so5029995e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785841498; x=1786446298; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZPso8bybjvlzpSiniMJSg48FKCs4+i7LpgHDKwGEwWY=;
 b=p0nI6ru86Lu83y21K4b8WFiT50D2xYv3fznJDFAzJn1HMj8Ki7cPVBv4rVdw6hIwtO
 XOhCgeNxPQxOnDDgkoKGCuiT1l3tIAgUVmXCY4q7e1YJzeq4N90hcGT7hb+qnMDcuczu
 eVF7QcI5bNJnJ6Ft+vrnq1gMmIHkcukgGlfOIvjCxPlgJKJmTwUs75HQ0z+Yo5P/amWG
 lP+LM5X3GLHxy9e6EHxs29ba+S6tTaR0C1E2144UPu+hIK9BDeNeIxqEBMulUhP4Z2PP
 T24I3QAXZ9PH2OUFLspFSTD1hMcXrhLS71YE4o6+qSBM7Mr31Vc2aSVSGZVJrnk5hGU1
 wsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785841498; x=1786446298;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPso8bybjvlzpSiniMJSg48FKCs4+i7LpgHDKwGEwWY=;
 b=VEbNNcqGudB4d0poUM3/SVxtH6Cw4dSWcK2Opux8KG4Ob02rjjoMM7aRt11CC9PaXk
 0ZbdvguMu9AJRL+Zm0ASD44dOB3cv1GAK70QEyvPeLaOSdbl8qOBxXYR46J1MQKzKi0I
 ul8j3n6lFI+VM5t94LNOJPClP0h6xg/Z7JKd0lJsXO0cG4H0zB97IfwSBVtHICVYejnU
 bRYj5kXI2N1CfC0CHNRJznyXKcnMY6tr4ddz4FS+Fwo+41AfV+SPSa8i637W03APVu5J
 hKzPpXm+tPO46UO74JjH1KzHnCzISRakxmGUKvmGrUcnl8YdvkaLsK08vBaDqTpM+PEc
 W/tg==
X-Gm-Message-State: AOJu0YxTQzOYh0ckmrZWyTWrAgcfkGiUGnD8K40prYgn69Id0WEqxO8p
 MmH2zSlEOtto6vhHfddUJBvAWRB3F87gA/UDaunGtmtbYGF08wASFDWN37HRL2f2wcW6PXOXvR2
 xqyKCVFjaysaVNQycl1cfiPbSeQzaiZyA8E7ZNM2/FNvA4LhC+WYsvlEG
X-Gm-Gg: AR+sD11MKp2jyWi0vOTUDYmPZgZB85ovemZUd1aPeIzyFd4KNIXwOHDYJQfi1VtLBA7
 IvwFeRJ2hZPG3yswy4EnxYzm1Ly1JLkwIG0OYYkdzspMSYRoWEvFkcDnKyoPheCzmmJ/A9lLSFK
 LxdrCFzlPSKFgAN9PYSuqRGRVcXXeROSmBeE79lPQ+yHIWmjMJQKQcTSnubMZqCgGoGLlZJRUDH
 MrLai5omlhhBhoN3DV303bvq8/7UrvcXnCdfmCVLTzENvrCHwdBuaW8Hsz4616QOzn50QTORTxa
 Mor4BeZMzJzbFhSrUq/3fsIxE2B0ex/mewO1l9D2dej+w9a0zbJqWQGnNQ3L6+r7lJKnBdhwvih
 mXFTz0qisfHX89GqwiIcZ/FphdNgFryboj+SsR+SMxMY+KXcKrOK7TExA9SeYAyf84euOaTHH1c
 U1CkHF5i3dMXCOSfEomHXvry4BWlhAeQ==
X-Received: by 2002:a05:600c:798:b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-49949fd988dmr60940675e9.2.1785841498616; 
 Tue, 04 Aug 2026 04:04:58 -0700 (PDT)
X-Received: by 2002:a05:600c:798:b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-49949fd988dmr60939745e9.2.1785841498235; 
 Tue, 04 Aug 2026 04:04:58 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:54bb:1189:33b6:6950:ef97?
 (p200300cfd73d54bb118933b66950ef97.dip0.t-ipconnect.de.
 [2003:cf:d73d:54bb:1189:33b6:6950:ef97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6besm40240584f8f.22.2026.08.04.04.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:04:57 -0700 (PDT)
Message-ID: <c449898e-4159-4c30-ae5c-87af9c2645d5@redhat.com>
Date: Tue, 4 Aug 2026 13:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
 <f7776822-106c-47d0-ada9-fab75f68c76d@redhat.com>
 <CA+spn3rjAu5EcWBwG4NJmwqobdggJmZYVPrvn5Yq58Zyf0NEDA@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3rjAu5EcWBwG4NJmwqobdggJmZYVPrvn5Yq58Zyf0NEDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.08.26 23:13, Connor Kite wrote:
> On Mon, Aug 3, 2026 at 5:36 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>
>> Can you document roughly what the function looks like? Because the type
>> (`GTraverseFunc`) is not defined in qemu. I know it has a boolean as a
>> return type, and that one argument of it is going to be `gpointer data`,
>> but surely it will also take a tree element.
>>
>> Hanna
> I have updated the comment to describe the usage of GTraverseFunc as
> below:
>
> /**
> * iova_tree_foreach:
> *
> * @tree: the iova tree to traverse
> * @func: the function called at every node. A true return value ends traversal.
> *              Arguments:
> *                  gpointer key: key of current node
> *                  gpointer value: value of current node
> *                  gpointer data: data passed in at g_tree_foreach call
> *              Return: gboolean
> * @data: an argument passed to func
> *
> * Wrapper to call g_tree_foreach on the underlying g_tree. g_tree_foreach will
> * traverse through every node of the tree, barring an early return. At each
> * node, g_tree_foreach calls func with pointers to the node key, node value,
> * and a pointer to data passed in by the caller.
> *
> * Return: None
> */

Awesome, thanks!

Hanna


