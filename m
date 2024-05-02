Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE11C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WPA-0006DS-Nq; Thu, 02 May 2024 09:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s2WP4-0006CR-Sb; Thu, 02 May 2024 09:23:14 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s2WP2-0004p3-2I; Thu, 02 May 2024 09:23:14 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 4425kFFZ030419; Thu, 2 May 2024 14:22:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=GtGaqU/gbvUP10DibhX9/KSUJTpSyAHdN8JvO1O8wuI=; b=
 SGgU0Zy42wXIlWw2JOsKBKstnBCnKP29I1w0jr732GGNOG2IVss3v+Scu1Vdgd32
 JfLNXQOerM5pub5V6ar51Wt9T1c3hajjLMRZQcykx2+2W2dxednaltvftpvCs4LK
 U1eUzZ98AxhmOFQjY4c7E5e66W6JsbZvN8+ohlSJDQW9E/okTYdv7lHHV8FRlHiI
 /kp9avnJ3UlrIAfScrFup9g17om4Qf+SRh74HSOi3cpBVsulTLvATlK8o8/9aGaS
 N5LkkF4qMrPpHHmgdFUFpM7u6IheVTy4Bhb3YUsC/Goe+gr/aurroRssAivkMM7P
 RApJY0b4Ww6WadvlAmcmgQ==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 3xv26q2u4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 14:22:30 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 442CrSf0005808; Thu, 2 May 2024 09:22:29 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 3xrvpyupf8-1;
 Thu, 02 May 2024 09:22:29 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com
 [172.27.166.123])
 by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 7C3A9638E5; 
 Thu,  2 May 2024 13:22:25 +0000 (GMT)
Message-ID: <ac86d9a7-02c6-9a07-4135-8327d17aca6b@akamai.com>
Date: Thu, 2 May 2024 08:22:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
References: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com> <ZjJqwg1H2nZbcekb@x1n>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <ZjJqwg1H2nZbcekb@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020085
X-Proofpoint-ORIG-GUID: kpjeY50XG6kvwQCv0RrcerjEhgDFzFRf
X-Proofpoint-GUID: kpjeY50XG6kvwQCv0RrcerjEhgDFzFRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501
 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020085
Received-SPF: pass client-ip=67.231.157.127; envelope-from=mgalaxy@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.296, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Yu Zhang / Jinpu,

Any possibility (at your lesiure, and within the disclosure rules of 
your company, IONOS) if you could share any of your performance 
information to educate the group?

NICs have indeed changed, but not everybody has 100ge mellanox cards at 
their disposal. Some people don't.

- Michael

On 5/1/24 11:16, Peter Xu wrote:
> On Wed, May 01, 2024 at 04:59:38PM +0100, Daniel P. Berrangé wrote:
>> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
>>> What I worry more is whether this is really what we want to keep rdma in
>>> qemu, and that's also why I was trying to request for some serious
>>> performance measurements comparing rdma v.s. nics.  And here when I said
>>> "we" I mean both QEMU community and any company that will support keeping
>>> rdma around.
>>>
>>> The problem is if NICs now are fast enough to perform at least equally
>>> against rdma, and if it has a lower cost of overall maintenance, does it
>>> mean that rdma migration will only be used by whoever wants to keep them in
>>> the products and existed already?  In that case we should simply ask new
>>> users to stick with tcp, and rdma users should only drop but not increase.
>>>
>>> It seems also destined that most new migration features will not support
>>> rdma: see how much we drop old features in migration now (which rdma
>>> _might_ still leverage, but maybe not), and how much we add mostly multifd
>>> relevant which will probably not apply to rdma at all.  So in general what
>>> I am worrying is a both-loss condition, if the company might be easier to
>>> either stick with an old qemu (depending on whether other new features are
>>> requested to be used besides RDMA alone), or do periodic rebase with RDMA
>>> downstream only.
>> I don't know much about the originals of RDMA support in QEMU and why
>> this particular design was taken. It is indeed a huge maint burden to
>> have a completely different code flow for RDMA with 4000+ lines of
>> custom protocol signalling which is barely understandable.
>>
>> I would note that /usr/include/rdma/rsocket.h provides a higher level
>> API that is a 1-1 match of the normal kernel 'sockets' API. If we had
>> leveraged that, then QIOChannelSocket class and the QAPI SocketAddress
>> type could almost[1] trivially have supported RDMA. There would have
>> been almost no RDMA code required in the migration subsystem, and all
>> the modern features like compression, multifd, post-copy, etc would
>> "just work".
>>
>> I guess the 'rsocket.h' shim may well limit some of the possible
>> performance gains, but it might still have been a better tradeoff
>> to have not quite so good peak performance, but with massively
>> less maint burden.
> My understanding so far is RDMA is sololy for performance but nothing else,
> then it's a question on whether rdma existing users would like to do so if
> it will run slower.
>
> Jinpu mentioned on the explicit usages of ib verbs but I am just mostly
> quotting that word as I don't really know such details:
>
> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com/__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOew9oW_kg$
>
> So not sure whether that applies here too, in that having qiochannel
> wrapper may not allow direct access to those ib verbs.
>
> Thanks,
>
>> With regards,
>> Daniel
>>
>> [1] "almost" trivially, because the poll() integration for rsockets
>>      requires a bit more magic sauce since rsockets FDs are not
>>      really FDs from the kernel's POV. Still, QIOCHannel likely can
>>      abstract that probme.
>> -- 
>> |: https://urldefense.com/v3/__https://berrange.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfyTmFFUQ$       -o-    https://urldefense.com/v3/__https://www.flickr.com/photos/dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf8A5OC0Q$  :|
>> |: https://urldefense.com/v3/__https://libvirt.org__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf3gffAdg$          -o-            https://urldefense.com/v3/__https://fstop138.berrange.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfPMofYqw$  :|
>> |: https://urldefense.com/v3/__https://entangle-photo.org__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOeQ5jjAeQ$     -o-    https://urldefense.com/v3/__https://www.instagram.com/dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfhaDF9WA$  :|
>>

