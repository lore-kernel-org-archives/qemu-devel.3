Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D526AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 18:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShXV-0005aN-Ur; Wed, 24 Jan 2024 12:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rShXT-0005Z2-TG; Wed, 24 Jan 2024 12:59:52 -0500
Received: from mail-db5eur02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2608::700]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rShXR-0000DM-T5; Wed, 24 Jan 2024 12:59:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRMbn2GRJg/BPYvKEgjWbdX9Glh7hgmQt4Uou3A5z3ivAJnRBHB27JOWKpjZ+PvPgfM/oM0mxuqQvKnbhkxwPMQtv0CvInyTSVaeeeDAFOCWk+z5erd4O+jONOiNtnQ4jb5eTCZpCPhEL/rIMbFuMZlAPQB18XzImS5nauQ/mCbQgk3RaYFqgwo37NNHHGu3nn/I6y/pc6MBoGXAiD9FaPViv/oh6FdH9+9fR2B0LyONnk0MG1vwjXR25d5ttdrAH9l3Y1rFVTu0HWQxocq3jaEm9ULTv4H5HRHPy1SMuMQUOQFKPzdO+wzyvJ1Hz/bjbUsxrtXrZPugXxN2y7k6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSmAGtpAgoWBqaXEH0E+WU90Yom6hDEbuVXLnPepx8s=;
 b=MbnTHpnG/V1Y4/f7mot4KBogAiJaJ4ng69pd9x2R76c3pgub8rOijhlfr8lL4mpVeBdou1V881nhWlHnQCT1nKxLTsu+cr+F82AVqKZSPkYsYujsQRGPvEHXmbxUSgNBTW0zOp2g/bcDfv0Sc1jY2QSl3i5rrgHsVOZxO4ihw7Ch8/4nZu8wJ+p7Hk6zqn12l16u6k1opkkHF2SJNbwuZgNJBXPCBR4ZWSZ3r1v9Y6E0oPSj2N6MWuWjfsc95TPb/LNwoXQYelVIFMj/FzolzHPPG4FOTGZne721soKyWWKhvx5zf28DLoWRwqgZkoi42j5Ph6ODSPHXjhK96JkMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSmAGtpAgoWBqaXEH0E+WU90Yom6hDEbuVXLnPepx8s=;
 b=u8v3VyiuUmPOw2ZwoL/EjhT6mEQQNlzW398icWT3Do5yCO9YDD7LOhS3/mL/J+WLB28hW6qG23eTwSOn8qnrsSBQrmaG1U+K64HAFJ3a02EbI0luvsmerFUOtq2EvELA1a2JFRy9tfP0E57FOx8Sx3MekeBDwEFZ29DkHJDqr6wpoP0sSddFRI4xlvxJ1O/AENWgWjutkSCcaZyPArfpZjX9XwS4W5X1zMy561o7srZlZnIVQ0oMOAzueEvZfIAryRkODis1Z3s/x4AR63IgnMHpKEC5NX0EeJ5XZSZpIdXavDXMEK1VEhVMi/6A2CcIf8yaqjK4ZfS48OCrWUE3gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB6472.eurprd08.prod.outlook.com (2603:10a6:20b:336::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:59:44 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 17:59:44 +0000
Message-ID: <e513bffc-636e-4921-b87d-be67a52457f1@virtuozzo.com>
Date: Wed, 24 Jan 2024 18:59:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/277: Use iotests.sock_dir for socket creation
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com
References: <20240124162257.168325-1-andrey.drobyshev@virtuozzo.com>
 <3v7hvc2kt7obfhvnfrgmtwk4ofvy5dmrkiho3cbqsm2vnfhnl2@6n5i47olcp64>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <3v7hvc2kt7obfhvnfrgmtwk4ofvy5dmrkiho3cbqsm2vnfhnl2@6n5i47olcp64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0143.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::27) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b64be1-d509-4b29-a9c0-08dc1d063f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEAnfFVyg5TKf81WfZ0tp1BGKu9gLU21MdIBAMXTLKDPz6LlVnrLrmQ+pswX4me2yHPZjbL/1jlL+ehdSfjAakAhb3WcvQEQcZ782JD7fZRykbQVlI8i7gVqbpyEgqmzh7eFKQPeMVh8wlkUUDpv57592DDsLmCCzaETX72N3/nskSgjTaNKgQNzb5bLPk2Q/u3aSBvZ+o/cEea0oCIWiQSX68WZjepwRMQYdIzXPLuL2ClAYZ0eh+ZumiifqSbHrammI6MtIx13EQ3voMxFtyZflPNAZMgDKfFaNax1VHcS/WzxQ10yNK/ng0kQsoH/IlM5cuhni6ZPWMusIGWW/gyhNR28IaSJUkATLrZSQtHw4Y+c4mkYwu+DdLKUpBa4CEL48acNi9wHxgze1E3lBRIej+7wIVGA9caLHudEOuiCNbxt0BIiF8SY2LilAKDoYP1OGADQTOZ165KWAw0moQ4VRnMQ5VQ8OWSKuQFTmAqnIARsFhqXlkFKaJUoq958ta8GeAzug24OWnEghS5NJPRBe3k0m1X12Am22leL4rmeSgt4+7tHxmz7UYK2z9IKfVCjK7Yl8rQOd2CxaULtzlkxMjoo7vx2C9rIURVSlvkhnUePqrfHcXU7KGQavZiKYBuFXS9sjXrtyF0HPWOL5893mEZWD5ujVOubWa08chrdFTA3xfG9qcKD4KorfKok
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(36756003)(86362001)(31696002)(38100700002)(2616005)(6486002)(26005)(6512007)(66556008)(66476007)(6506007)(110136005)(478600001)(2906002)(66946007)(316002)(6636002)(53546011)(6666004)(4326008)(8676002)(5660300002)(8936002)(43740500002)(33290500001)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnkxVmZRSEM5TUpJajlZTkxyZUhqZWNyVFBuUWpiNTYzV0RIaERSbk1CL3E0?=
 =?utf-8?B?Z0dvTURyNTRTVW5QQlp0aGVZeVJYcWRYbisvbGNvVkY1WnJLQlRKUi9Qb2c2?=
 =?utf-8?B?aXZ4UXVERTNkSS9Uc1JpN09xYVYzMlFRUFAwQ1JuWUc0Z1FIOVZZL21nZzVs?=
 =?utf-8?B?SDlzbjhNN3luUzNkLzd5TnVOTURnZldaSm80K2FGNk91b3VSWXpTZmlqSFV1?=
 =?utf-8?B?bVh6NmZXcFNTNGZDQTZVYXJXVm1ob1FCZnJpOFM4MWRCTWIzV1NRbWtaVnBO?=
 =?utf-8?B?aUpzSlhMUVBZSVpBSTJ2Q2tqa0lvZ3VjWkZvazNVYWpMTE9rUDFjeUc0Q3U2?=
 =?utf-8?B?NXlxR0FySUdKUnJMTHFGeEhRRE13cjlrTXJtOFFDUGFxU0d1THo4emNFRlh0?=
 =?utf-8?B?TllWcXpTOTd0UXJZK2xIWmNsRzQ2OWc5TWlyNm9qZkFKUElFSWo5UmtBL1BS?=
 =?utf-8?B?cmlyZG85MS9OYzNLZ3QzTVllWXFhOUoxT1Q0bys5SDhSNHU3NkVVR3JOcWhl?=
 =?utf-8?B?QmswTzlJNHBON2p2SkRQZXVJbEVhYXlXeGJPTTRTRFhFTW15amdROGZXczNH?=
 =?utf-8?B?WG80UjM1RXlLcExWOHVadzM5bEhVQjVkZjVyN3pCV0p2dm01RUhJTUZlZ0h5?=
 =?utf-8?B?SEVjSEV2ZXhaUHFhTlFTTStSRnZkVFl0VG9JbnNKVzhXZjVnRVV5bFhCZS9U?=
 =?utf-8?B?TVdVRldvWkRDYldjSzdJcWs5SHRKZHViZDVOdHlBUStMQUlmMVVTMEtSaG9n?=
 =?utf-8?B?bEllOGtrUnYyLys0ei9ObTJuQUV5WGY1Zld1SUpCUkhXN2E4UDhmM2ZoOHlk?=
 =?utf-8?B?Q0hyOEF1Tk4zL0tQZkxpZnhaM2JUVWw5bFh6WFpRRTZpbjJ1Wk1EL2xEamIv?=
 =?utf-8?B?Z0J6cU5hTzdldmZ3M3NsUUxYUVdTWnZMd2luRnAzeW1mT2VjeWRST2pMTy9K?=
 =?utf-8?B?RVRaZGdObDcyQ2swOVNvZHZvcnRuL0t5U2NaRkdTd29KRmlIQTZZVUoxWUZ6?=
 =?utf-8?B?MzJvOVR2TFBCWGdjY2duaHdGdzJDTkZkRHV6UnFhMDdSOG15dFcxWkl6YXpt?=
 =?utf-8?B?M2kzMjlLZTQ1Znh0aDZuV2o0Y0lhMzRBYjZTOVJMMU9iMUh1RzR3NS90NHdZ?=
 =?utf-8?B?bjZBbkMyaHlERnZnSnozTEFZMVJYREhncHJVQXhTVVZUUkhPR1hFUHRHNW92?=
 =?utf-8?B?TFdXclorRm52ODRuNEN6TmFVb0E4SXZYTVVIbjhGUldNbGtBcFRmRnRiUWZk?=
 =?utf-8?B?QVhUcHVDelpWKys4SFp5OXc2UllEWWpWOU05cldJNWRLTW9YdERrMjl3QVNa?=
 =?utf-8?B?MjFEZ0JoZkRCOThNb2pudzZ2Z1JLMFlFQkhzb20zVGJTaGg1Z1V2SDIyTU04?=
 =?utf-8?B?cVA3YmNQSTQvTm9scWhYN3p3UHU4OFNFTDFlSEoxU2JJVHRQaWZhak53Qzdl?=
 =?utf-8?B?dkJWTXBFakJiRGRyWkVBTlk5Y21YbG1BUVB3Ykp3WUUvanpxKytYSmhpYVZC?=
 =?utf-8?B?NjlvUkZJZy9FakNnV2Zyc2tlWXhJdmRoWUlRUW9McGRaUHcwVDRUYVZoc21v?=
 =?utf-8?B?N3draVFhZ2ZsT2I5M1RiUlpYR2g3TDRpZHZ2cHMvZWEydVRORUtyZ2VsUU5V?=
 =?utf-8?B?TDBUZHdtenh1V2JqSkpzcXpwN05ucVNabzM4WlB5QlhuUEgrUVRqbDZpWThN?=
 =?utf-8?B?VWNnM1VhOWROenBXV1BRNXZFcE1WUmR3T2grUC9uVnlCOFN6a1ZHZWFrRFRx?=
 =?utf-8?B?REVTcGtVbzI2Z3pJWHZOZVVLYkNoNU5wNGQ4UEx6dkZsb0pQY294akpIcTNi?=
 =?utf-8?B?Ny9yZ0dFcGpxdS9EREV0ZnhNZEZIUUJZTFMxUDZWdlBwZms2QnkrY1pEVjdQ?=
 =?utf-8?B?VlpmU2tVQWdocGgvcHhWU3I0YVFTOWdrZGJLU010N0c5VmZWL3FYLzdhVWRq?=
 =?utf-8?B?cll2NURxVUdjaEFmM1hWYjZaREpHbkptdllKR3ZTVW1PM0V6ZEJzVjZ3Z1RM?=
 =?utf-8?B?dkVFdkRYNG1HT3dOaDluM0RxdjFBRko5MlU0b2ExazU2b1loM0NXQ2wzR2FV?=
 =?utf-8?B?Z05vOWdERnVzY1ZoNTQvNWt6NEVVZUh0QzZmNGEvYWI3eUFTZERjOVRsbml0?=
 =?utf-8?Q?Zes1u5jbOnKw2ZNS1XVpF/Byr?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b64be1-d509-4b29-a9c0-08dc1d063f1e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:59:44.7191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCwT33afxhKOrBsfcU8zxBxw1Vz61rY7hhz8Ole0FU/SUleF1+gR1BMAOsctrQgEvOTOdGXNvq/RRiiRp1SDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6472
Received-SPF: pass client-ip=2a01:111:f403:2608::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 18:43, Eric Blake wrote:
> On Wed, Jan 24, 2024 at 06:22:57PM +0200, Andrey Drobyshev wrote:
>> If socket path is too long (longer than 108 bytes), socket can't be
>> opened.  This might lead to failure when test dir path is long enough.
>> Make sure socket is created in iotests.sock_dir to avoid such a case.
>>
>> This commit basically aligns iotests/277 with the rest of iotests.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/277 | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
>> index 24833e7eb6..4224202ac2 100755
>> --- a/tests/qemu-iotests/277
>> +++ b/tests/qemu-iotests/277
>> @@ -27,7 +27,8 @@ from iotests import file_path, log
>>   iotests.script_initialize()
>>   
>>   
>> -nbd_sock, conf_file = file_path('nbd-sock', 'nbd-fault-injector.conf')
>> +conf_file = file_path('nbd-fault-injector.conf')
>> +nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
>>   
>>   
>>   def make_conf_file(event):
>> -- 
>> 2.39.3
>>
I would say that potentially the same code is present
in 264, it is :
disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
nbd_uri = 'nbd+unix:///?socket=' + nbd_sock

