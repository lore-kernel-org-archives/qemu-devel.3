Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B9C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 04:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucclQ-0005dO-AE; Fri, 18 Jul 2025 00:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uccia-00036t-47; Fri, 18 Jul 2025 00:29:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ucciW-0005ON-57; Fri, 18 Jul 2025 00:29:07 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56I4SWSp051498
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Jul 2025 13:28:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fmnmDlQHInqm6RvSdl1bn9y+fRIwHL6/BQ0YXiXcRbU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752812912; v=1;
 b=FGWlmrQea8cdfEw7Tqp4oDXKU3cAvbLPKaOUGfOPey7eVAAZV6WmE8WPuS3MfdLD
 y5Up5sc2ON7DTfCcLa4eMbGol1JDeSOYlMte/TAxXZ78iTYO7aqVwzbHKrhQLX6q
 gfaXQwsXF2zshCSQsXu+frJ+BrKKyfznlTAUK8OTGeKndnBytzLsBqdVuHynfqwr
 YJjh/9Te1rpvrnLQO7xxPlH+E5rrj+hx9oZo2IETz/lLFfZ/RD5o52f3haH50CGe
 +mfm11cU0mXTeHTG6mTjJakR490biygvfkpRrjvQJfIsb28+26qN/3cX/mrABL4J
 ijzgGMODP6gxSnaFyU2vcg==
Message-ID: <0447e269-c242-4cd7-b68e-d0c7211784a7@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Jul 2025 13:28:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
 <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
 <aHkskfsMNVgjoV2y@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aHkskfsMNVgjoV2y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/18 2:02, Daniel P. Berrangé wrote:
> On Thu, Jul 17, 2025 at 12:34:21PM +0900, Akihiko Odaki wrote:
>> On 2025/07/17 9:37, Arun Menon wrote:
>>> This is an incremental step in converting vmstate loading
>>> code to report error via Error objects instead of directly
>>> printing it to console/monitor.
>>> It is ensured that ram_postcopy_incoming_init() must report an error
>>> in errp, in case of failure.
>>>
>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>> ---
>>>    migration/postcopy-ram.c | 9 ++++++---
>>>    migration/postcopy-ram.h | 2 +-
>>>    migration/ram.c          | 6 +++---
>>>    migration/ram.h          | 2 +-
>>>    migration/savevm.c       | 2 +-
>>>    5 files changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>> index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
>>> --- a/migration/postcopy-ram.c
>>> +++ b/migration/postcopy-ram.c
>>> @@ -681,6 +681,7 @@ out:
>>>     */
>>>    static int init_range(RAMBlock *rb, void *opaque)
>>>    {
>>> +    Error **errp = opaque;
>>>        const char *block_name = qemu_ram_get_idstr(rb);
>>>        void *host_addr = qemu_ram_get_host_addr(rb);
>>>        ram_addr_t offset = qemu_ram_get_offset(rb);
>>> @@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
>>>         * (Precopy will just overwrite this data, so doesn't need the discard)
>>>         */
>>>        if (ram_discard_range(block_name, 0, length)) {
>>> +        error_setg(errp, "failed to discard RAM block %s len=%zu",
>>> +                   block_name, length);
>>>            return -1;
>>>        }
>>> @@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>>>     * postcopy later; must be called prior to any precopy.
>>>     * called from arch_init's similarly named ram_postcopy_incoming_init
>>>     */
>>> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>>> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
>>>    {
>>> -    if (foreach_not_ignored_block(init_range, NULL)) {
>>> +    if (foreach_not_ignored_block(init_range, errp)) {
>>>            return -1;
>>>        }
>>> @@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
>>>        return false;
>>>    }
>>> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>>> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
>>>    {
>>>        error_report("postcopy_ram_incoming_init: No OS support");
>>>        return -1;
>>> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
>>> index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
>>> --- a/migration/postcopy-ram.h
>>> +++ b/migration/postcopy-ram.h
>>> @@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
>>>     * postcopy later; must be called prior to any precopy.
>>>     * called from ram.c's similarly named ram_postcopy_incoming_init
>>>     */
>>> -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
>>> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
>>>    /*
>>>     * At the end of a migration where postcopy_ram_incoming_init was called.
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
>>>    /**
>>>     * ram_postcopy_incoming_init: allocate postcopy data structures
>>>     *
>>> - * Returns 0 for success and negative if there was one error
>>> + * Returns 0 for success and -1 if there was one error
>>
>> This is true but not relevant in this patch's goal.
>>
>> Besides, I'm not in favor of letting callers make an assumption on integer
>> return values (i.e., let callers assume a particular integer value in the
>> error conditions). It is subtle to make a mistake to return -errno while the
>> documentation says it returns -1.
> 
> In general I would consider it bad practice to have an method
> with "Error **errp" that also returns an errno. 95% of the time
> the errno is just there as further info on the error scenario,
> which "errp" obsoletes. Only in the rare cases where the caller
> needs to take functional action based on errno values, is it
> appropriate to contine returning '-errno'.> > IOW, I'd consider this appropriate for the patch as is.> >> I think 
a proper way to avoid bugs due to return values here is to change
>> the type to bool, which ensures there are two possible values; that is a
>> nice improvement but something that can be done later.
> 
> That doesn't guarantee avoidance of bugs, as bool values can be
> assigned to & compared against integers.

Returning -errno with "Error **errp" is indeed a bad practice, but 
someone may write a return statement with -errno by mistake as long as 
the type is int. For callers, it is a good defensive coding practice to 
assume any negative value indicates an error as it will dismiss the 
difference of -1 or -errno, and it is what the existing documentation 
implicitly suggests.

On the other hand, a function can never have a bug to return -errno if 
its return value type is bool.

Regards,
Akihiko Odaki

