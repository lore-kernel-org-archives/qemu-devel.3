Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DFFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTH1N-0000FI-0o; Mon, 15 Jul 2024 04:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTH1L-0000EL-WB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:25:20 -0400
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTH1J-0000Mp-9T
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:25:19 -0400
Received: from zmtaauth06.partage.renater.fr (zmtaauth06.partage.renater.fr
 [194.254.241.27])
 by smtpout20.partage.renater.fr (Postfix) with ESMTP id 3B733BFBAE;
 Mon, 15 Jul 2024 10:25:07 +0200 (CEST)
Received: from zmtaauth06.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPS id BF0AC1000C5;
 Mon, 15 Jul 2024 10:24:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTP id AB4501001BD;
 Mon, 15 Jul 2024 10:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth06.partage.renater.fr AB4501001BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1721031872;
 bh=Iwqatw1eAIOTmJdOTQVQTTlEq89nG/N6ghwAeb+ITak=;
 h=Message-ID:Date:MIME-Version:From:To;
 b=XKu5pQ2MNuXlQoXtGmtWBb1yWqKNnc2LOyhJP3tbip7jmzqTRJxbu7wCoDlPaKUZj
 z7CO7Nlx9n5szgVOAW8g3uVW4Q645ckr9auguS57Le+Umh+EfQPAtFsZ9dUbNM1WCk
 o4kLwU++0dp+4UcUehrs0xsDbG+SCbi4qCRvYg2DQysq2isX+ECrsEuXX3ryVZVJ0d
 FVBSfK1G2q1mVoKK6mAV6W/rGUUzuhmE6A55+raJYweXkgeW6giGi5VMOz2ro3YKj7
 MjmJRJh4FT8B7J/MceoDhSD8nIta/RLCJoqz1G3wo2xAuwmCqA3jO0vrBB80LI/hAo
 o6Nu2JfSpvLgg==
Received: from zmtaauth06.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth06.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id d-YGkemk9OgO; Mon, 15 Jul 2024 10:24:32 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.250])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPA id 4AB311000C5;
 Mon, 15 Jul 2024 10:24:32 +0200 (CEST)
Message-ID: <150b7d98-77b4-407a-becf-ef3dc06d14b3@grenoble-inp.org>
Date: Mon, 15 Jul 2024 10:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
From: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
 <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
 <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
Content-Language: en-US
In-Reply-To: <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at clamav04
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomhepufhimhhonhcujfgrmhgvlhhinhcuoefuihhmohhnrdfjrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrgheqnecuggftrfgrthhtvghrnhepgeduudevgeegveeigffgjeefteffheektefhieduteevgedvfefgveefteffjedunecukfhppeduleegrddvheegrddvgedurddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehtddphhgvlhhopedukeekrddvfedurdduuddrudekgedpmhgrihhlfhhrohhmpefuihhmohhnrdfjrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrghdpnhgspghrtghpthhtohepjedprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegvrhgunhgrgigvsegtrhgrnhhsrdhorhhgpdhrtghpthhtohepmhgrrdhmrghnughouhhrrhesghhm
 rghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgh
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.241.31;
 envelope-from=Simon.Hamelin@grenoble-inp.org;
 helo=smtpout02-ext4.partage.renater.fr
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_HELO_IP_MISMATCH=2.368, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 7/15/24 10:09, Simon Hamelin wrote:
> Hello Pierrick,
>=20
> On 7/12/24 19:23, Pierrick Bouvier wrote:
>> Hello Simon,
>>
>> On 7/12/24 00:53, Simon Hamelin wrote:
>>>
>>>
>>> On 7/11/24 12:03, Alex Benn=C3=A9e wrote:
>>>>> +static void exit_emulation(int return_code)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 exit(return_code);
>>>>> +}
>>>>> +
>>>>> +static void exit_icount_reached(unsigned int cpu_index, void *udat=
a)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_plugin_outs("icount reached, exiting\n");
>>>>> +=C2=A0=C2=A0=C2=A0 exit_emulation(icount_exit_code);
>>>>> +}
>>>>> +
>>>>> +static void exit_address_reached(unsigned int cpu_index, void *uda=
ta)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata)=
;
>>>>> +=C2=A0=C2=A0=C2=A0 g_mutex_lock(&addrs_ht_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 int exit_code =3D GPOINTER_TO_INT(
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_hash_table_lookup(add=
rs_ht, GUINT_TO_POINTER(insn_vaddr)));
>>>>> +=C2=A0=C2=A0=C2=A0 g_mutex_unlock(&addrs_ht_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_printf("0x%" PRIx64 " re=
ached, exiting\n",
>>>>> insn_vaddr);
>>>>
>>>> Dont intermix variable declarations, put them at the top of the bloc=
k.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_plugin_outs(msg);
>>>>> +=C2=A0=C2=A0=C2=A0 exit_emulation(exit_code);
>>>>> +}
>>>>
>>>> How about something like:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 static void exit_emulation(int return_code, char =
*message)
>>>> =C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_outs(message)=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(message);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(return_code);
>>>> =C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0 static void exit_icount_reached(unsigned int cpu_=
index, void=20
>>>> *udata)
>>>> =C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D G=
POINTER_TO_UINT(udata);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_pr=
intf("icount reached at 0x%" PRIx64=20
>>>> ", exiting\n", insn_vaddr);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_emulation(icount_exi=
t_code, msg);
>>>> =C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0 static void exit_address_reached(unsigned int cpu=
_index, void=20
>>>> *udata)
>>>> =C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D G=
POINTER_TO_UINT(udata);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_pr=
intf("0x%" PRIx64 " reached,=20
>>>> exiting\n", insn_vaddr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int exit_code;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_mutex_lock(&addrs_ht_lo=
ck);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_code =3D GPOINTER_TO=
_INT(
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
_hash_table_lookup(addrs_ht,=20
>>>> GUINT_TO_POINTER(insn_vaddr)));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_mutex_unlock(&addrs_ht_=
lock);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_emulation(exit_code,=
 msg);
>>>> =C2=A0=C2=A0=C2=A0 }
>>>>
>>>>
>>>
>>> Looks good to me, will definitly put that in the next patch !
>>>
>>>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const qemu_info_t=20
>>>>> *info, int argc,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char **argv)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 addrs_ht =3D g_hash_table_new(NULL, g_direct_eq=
ual);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 insn_count_sb =3D=20
>>>>> qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
>>>>> +=C2=A0=C2=A0=C2=A0 insn_count =3D qemu_plugin_scoreboard_u64_in_st=
ruct(
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn_count_sb, Instruct=
ionsCount, insn_count);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < argc; i++) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *opt =3D argv[i];
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_auto(GStrv) tokens =3D=
 g_strsplit(opt, "=3D", 2);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_strcmp0(tokens[0]=
, "icount") =3D=3D 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1],=20
>>>>> ":", 2);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
>>>>
>>>>
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D
>>>>> NULL) {
>>>>
>>>> I don't think strstoull would even parse something with - in it so I
>>>> would just do:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 if (icount =3D=3D 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fail */
>>>> =C2=A0=C2=A0=C2=A0 }
>>>>
>>>
>>> According to the GLib documentation: "Note that input with a leading
>>> minus sign (-) is accepted, and will return the negation of the parse=
d
>>> number, unless that would overflow a guint64". So i guess we need to
>>> keep this check.
>>>
>>>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rs=
t
>>>>> index f7d7b9e3a4..954623f9bf 100644
>>>>> --- a/docs/devel/tcg-plugins.rst
>>>>> +++ b/docs/devel/tcg-plugins.rst
>>>>> @@ -642,6 +642,28 @@ The plugin has a number of arguments, all of=20
>>>>> them are optional:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 configuration arguments implies ``l2=3Don`=
`.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 (default: N =3D 2097152 (2MB), B =3D 64, A=
 =3D 16)
>>>>> +- contrib/plugins/stoptrigger.c
>>>>> +
>>>>> +The stoptrigger plugin allows to setup triggers to stop emulation.
>>>>> +It can be used for research purposes to launch some code and=20
>>>>> precisely stop it
>>>>> +and understand where its execution flow went.
>>>>> +
>>>>> +Two types of triggers can be configured: a count of instructions=20
>>>>> to stop at,
>>>>> +or an address to stop at. Multiple triggers can be set at once.
>>>>> +
>>>>> +By default, QEMU will exit with return code 0. A custom return=20
>>>>> code can be
>>>>> +configured for each trigger using ``:CODE`` syntax.
>>>>> +
>>>>> +For example, to stop at the 20-th instruction with return code 41,=
=20
>>>>> at address
>>>>> +0xd4 with return code 0 or at address 0xd8 with return code 42::
>>>>> +
>>>>> +=C2=A0 $ qemu-system-aarch64 $(QEMU_ARGS) \
>>>>> +=C2=A0=C2=A0=C2=A0 -plugin=20
>>>>> ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D0xd4,addr=
=3D0xd8:42 -d plugin
>>>>> +
>>>>> +The plugin will log the reason of exit, for example::
>>>>> +
>>>>> +=C2=A0 0xd4 reached, exiting
>>>>> +
>>>>> =C2=A0=C2=A0 Plugin API
>>>>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> Otherwise it looks good to me. Unless you want to tackle additional=20
>>>> exit
>>>> modes?
>>>>
>>>> What is your current use case for this?
>>>>
>>>
>>> I'm currently using this plugin to determine where my programm stop
>>> after a given number of instructions executed.
>>>
>>
>> Could you share a bit more information on the final goal, if possible?
>> Is that used for fuzzing binaries, security analysis, or other things?
>=20
> I'm currently using this plugin for security analysis purposes.=20
> Basically my goal is to simulate fault injection using QEMU. To do so=20
> I'm using this plugin along with another plugin that skips an=20
> instruction at a given address. With this plugin I'm able to see how th=
e=20
> program reacts to the fault and stop it with a custom return code.=20
> Basically there are 4 cases:
>  =C2=A0=C2=A0 - The fault does not disrupt the program and it reaches t=
he expected=20
> address.
>  =C2=A0=C2=A0 - The fault disrupt the program and it reaches an unexpec=
ted address=20
> known as the "target" address.
>  =C2=A0=C2=A0 - The fault disrupt the program in such a way that it exe=
cutes a lot=20
> of instructions without reaching the expected address, this situation i=
s=20
> known as a "timeout".
>  =C2=A0=C2=A0 - The fault crashes the guest, causing it to reach an err=
or handler=20
> address.
>=20
> In short, here's a command line that illustrates how I use the plugin:
>=20
> $ qemu-system-aarch64 $(QEMU_ARGS) -plugin=20
> ./contrib/plugins/libstoptrigger.so,icount=3Dtimeout_count,addr=3Daddr=3D=
expected_addr:0,error_handler_addr:1,target_addr:2 -d plugin
>=20
> --=20
> Simon Hamelin

Look like I made a little mistake in the command line example, here is=20
the correct one:

qemu-system-aarch64 $(QEMU_ARGS) -plugin=20
./contrib/plugins/libstoptrigger.so,icount=3Dtimeout_count,addr=3Dexpecte=
d_addr:0,addr=3Derror_handler_addr:1,addr=3Dtarget_addr:2=20
-d plugin

--
Simon Hamelin


