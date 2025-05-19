Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11255C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3kv-0004zj-Qw; Mon, 19 May 2025 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH3kt-0004zZ-FD
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:54:23 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH3kr-0007rt-My
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:54:23 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 445F5219C22AE;
 Mon, 19 May 2025 18:54:20 +0200 (CEST)
Message-ID: <62906762-3d8e-4455-a1a2-e66396ec7dd1@lauterbach.com>
Date: Mon, 19 May 2025 18:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] mcd: Implement server connection API
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 armbru@redhat.com, christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-9-mario.fleischmann@lauterbach.com>
 <aCW6vZivY9-Yt8-H@redhat.com>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <aCW6vZivY9-Yt8-H@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747673660286
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 15.05.2025 11:58, Daniel P. Berrangé wrote:

> On Wed, Apr 30, 2025 at 07:27:29AM +0200, Mario Fleischmann wrote:
>> This commit implements the necessary operations required to establish
>> a connection with the MCD server:
>>
>> * query information about the server
>> * connect to "
>> * disconnect from "
>>
>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>> ---
>>  mcd/mcd_qapi.c         |  13 +++
>>  mcd/mcd_qapi.h         |   2 +
>>  mcd/mcd_server.c       | 110 +++++++++++++++++++++-
>>  mcd/mcd_stub.c         |  98 ++++++++++++++++++++
>>  qapi/mcd.json          | 205 +++++++++++++++++++++++++++++++++++++++++
>>  tests/qtest/mcd-test.c |  96 +++++++++++++++++++
>>  tests/qtest/mcd-util.c |  60 ++++++++++++
>>  tests/qtest/mcd-util.h |   9 ++
>>  8 files changed, 588 insertions(+), 5 deletions(-)
>>
>> diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
>> index 9a99866..d2a2926 100644
>> --- a/mcd/mcd_qapi.c
>> +++ b/mcd/mcd_qapi.c
> 
> 
>> +MCDQryServersResult *qmp_mcd_qry_servers(const char *host, bool running,
>> +                                         uint32_t start_index,
>> +                                         uint32_t num_servers, Error **errp)
>> +{
>> +    MCDServerInfoList **tailp;
>> +    MCDServerInfo *info;
>> +    mcd_server_info_st *server_info = NULL;
>> +    bool query_num_only = num_servers == 0;
>> +    MCDQryServersResult *result = g_malloc0(sizeof(*result));
>> +
>> +    if (!query_num_only) {
>> +        server_info = g_malloc0(num_servers * sizeof(*server_info));
> 
> This multiplication is (theoretically) subject to overflow. To eliminate
> this risk, this should use
> 
>     g_new0(mcd_server_info_st, num_servers)
> 
> which will validate overflow & abort if hit.
> 
> There are many more instances of this code pattern in the series
> 
> $ git diff -r master | grep g_malloc | grep ' \* '
> +        .tx = g_malloc(txlist->num_tx * sizeof(mcd_tx_st)),
> +        server_info = g_malloc0(num_servers * sizeof(*server_info));
> +        system_con_info = g_malloc0(num_systems * sizeof(*system_con_info));
> +        device_con_info = g_malloc0(num_devices * sizeof(*device_con_info));
> +        core_con_info = g_malloc0(num_cores * sizeof(*core_con_info));
> +        memspaces = g_malloc0(num_mem_spaces * sizeof(*memspaces));
> +        reg_groups = g_malloc0(num_reg_groups * sizeof(*reg_groups));
> +        regs = g_malloc0(num_regs * sizeof(*regs));
> +        ctrig_info = g_malloc0(num_ctrigs * sizeof(*ctrig_info));
> +        trig_ids = g_malloc0(num_trigs * sizeof(*trig_ids));
> 
> 
> QEMU is a bit inconsistent, but we have a slight bias in favour
> of using g_new0, even for single struct allocations.
> 
> IMHO being in the habit of always using g_new0 instead of g_malloc
> makes it less likely for people to inadvertantly introduce the
> multiplication overflow code pattern with g_malloc.

Oh, I didn't know that function, thanks for pointing it out! I agree,
it's the more elegant option.

