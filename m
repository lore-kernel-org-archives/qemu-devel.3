Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D4FF3D33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCHc-0007yF-UP; Thu, 05 Mar 2026 12:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCHc-0007u5-0J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCHZ-0005N7-W7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDS+E0ywxEcabzEhzNrAbczq9vFcntt8roiwPe2hSow=;
 b=e1v9L65GQniocTjppmR16bqVMtb5tv7JrEcKnV+wzNeoWYZB/TvRZ1jpZ0pJq1Ttf9riUO
 M8IjsO+ObbPZ+TPDvaMdt0mT0iT52Fa64M5HRVYXi8dShgdbfiR4z/4WpfOHgGIlzpQUdO
 1HPD+hMy4u+nlZeZ1nBPerVooCoYvoc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cS4Ox3rbN2qpF7oY4ApYRA-1; Thu, 05 Mar 2026 12:14:39 -0500
X-MC-Unique: cS4Ox3rbN2qpF7oY4ApYRA-1
X-Mimecast-MFC-AGG-ID: cS4Ox3rbN2qpF7oY4ApYRA_1772730879
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506bfff75edso732673391cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772730879; x=1773335679; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wDS+E0ywxEcabzEhzNrAbczq9vFcntt8roiwPe2hSow=;
 b=YD+F2/6QixBEWp/LhOaFUUOIvsb72ozBB5PDZwSlw8XWhcYzmToR/GR1cwKtHvJvIR
 dBOMJIs1HHBYr7aUhsQm/wbXBUAGzhzNi1PJjqyMzQUuU/eZJ3Y/L/Z6WoNn+XUfpIcz
 Q7MX6w61HIsqTmahFdBlvxswGAnbxRylgL+TcBqUjJVHNrdf5MQcPy/xqQwi7O0ih8qQ
 P8XGtPDUp5p9cF2LW0lnsHzhGSz5w6QF6jcKvHXLu6uxh943KWA0G9Lg5mJyHyi7MeOf
 vLyJtUZGesJ7CJ4oZaqznBymz+UjaXWxxugZSz9tBAGG7uo02uhKLJNXQy6X7dc8HYcm
 Ng2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730879; x=1773335679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDS+E0ywxEcabzEhzNrAbczq9vFcntt8roiwPe2hSow=;
 b=LSH+sXHgM/p3pVNt0A4eJvVY6tn7CAaFlUzeYUjYpGH3aXiQNaISm64uxmTjCfSmGS
 yDzP5j3EjmKZgffv/GlrG/Dc3CQRUic5zd964jjNUIiB+p9GHF6OWUR7nrr3zzBuDUWm
 LBufvL+PHiIbi6UEMgFpiY3E2I2MmOBwuxeFQhb4UTxTNlp57gn2+94ou8xSb1Xag7O+
 LRd7PbuojOVd7j6lpX6ng/jQws2BNq8sKXeHiHLtnYPeidUsbpHsaBNQARgADJ5wMUVI
 kV86WgKz8Cg+0xn/itIlFaVdC+JFFdTFn+75XFBfljK2Gx4CeqVDr6lbHvcUqmd+cEkA
 xjCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVDQyHAZHNVBAvhIi7Zw68ZxWxU9OYcCqoXUXoJke1tP0X3re92U53FBDTbzlF1wIarr9U+55LUnj6@nongnu.org
X-Gm-Message-State: AOJu0Yw3/k4jyuxylb/SctiX9ecKEfrwrjciljVILyOnQkRJ9s6cEwfT
 IWJdDw0Z30M1BD32kVLM+5xdqSwxoPNd+UeWCWP9N1H2Z6YBYCX9F2mR1MmBkIFde4/HcMCpgpK
 Bb3528k0rqJn90hw3K+8WWjfk/8ZZDuCvgYG6+mj9/qmAjQrhj5SUZK+V
X-Gm-Gg: ATEYQzzm/h5asogSUqoR8SH1M13DF3mV4wzVrNlGgTdrVR3M7R6pQ2pcRZmM2f4gUTX
 2EehjHBEwQ+czQGwMV9myzLxcRVycjWX2eDGFIki1BUVG14i33XBwN0aYZZpxvMTDRj5zRBlatd
 Oo7hdeNA4GTqpQlWbzFP5hmueaWTfxOHWi79XliIU0+B6hLS2BkxCaBVsvIHIh6eR7ONAq4+qe5
 22ddjUqZcbyqU4iksuOAiumtSDrKa8fA2Ym813EqVf7LcY6azKTpR+LFYrolpXstx1AkNlhr2YL
 sNs5wY5UEjKR71Tte6wLtl3qICwj1CtqJjrLkvDbHH718HfUloYHOiTkKNHVdaBhuO/tW0N6nL7
 h2ZZ68KtrsBG3gA==
X-Received: by 2002:a05:622a:130f:b0:4ee:155d:b560 with SMTP id
 d75a77b69052e-508f1ce3e30mr4998381cf.8.1772730879074; 
 Thu, 05 Mar 2026 09:14:39 -0800 (PST)
X-Received: by 2002:a05:622a:130f:b0:4ee:155d:b560 with SMTP id
 d75a77b69052e-508f1ce3e30mr4997881cf.8.1772730878631; 
 Thu, 05 Mar 2026 09:14:38 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899e608cfc6sm126484506d6.14.2026.03.05.09.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:14:38 -0800 (PST)
Date: Thu, 5 Mar 2026 12:14:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gautam Menghani <gautam@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Weil <sw@weilnetz.de>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 "open list:Floppy" <qemu-block@nongnu.org>,
 "open list:XIVE" <qemu-ppc@nongnu.org>,
 "open list:S390 channel subs..." <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 17/18] migration: drop VMStateField.err_hint
Message-ID: <aam58gNtpCRin-NN@x1.local>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-18-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304212303.667141-18-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, Mar 05, 2026 at 12:23:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> The field is unused, all users of VMSTATE_*_EQUAL pass _err_hint=NULL.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


